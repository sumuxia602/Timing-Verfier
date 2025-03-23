from sample.frontend.cfg import TCFGNode, LoopKind, TCFGEdgeKind, TCFGEdge
import graphviz


class CriticalCfg:
    def __init__(self, tcfg_nodes: list[TCFGNode]) -> None:
        assert tcfg_nodes
        self.nodes = tuple(tcfg_nodes)

    def refine_ccfg(self, ccfg: list[TCFGNode]) -> list[TCFGNode]:
        refined_ccfg: list[TCFGNode] = []
        for node in ccfg:
            refined_ccfg.append(TCFGNode(node.bb, node.proc_name, node.nid))

        all_new_in_edges: list[list[tuple[int, TCFGEdgeKind]]] = []
        all_new_out_edges: list[list[tuple[int, TCFGEdgeKind]]] = []
        
        for node in ccfg:
            new_in_edges: list[tuple[int, TCFGEdgeKind]] = []
            for edge in node.in_edges:
                if edge.src in ccfg:
                    new_in_edges.append(tuple([ccfg.index(edge.src), edge.edge_kind]))
            new_out_edges: list[tuple[int, TCFGEdgeKind]] = []
            for edge in node.out_edges:
                if edge.dst in ccfg:
                    new_out_edges.append(tuple([ccfg.index(edge.dst), edge.edge_kind]))
            all_new_in_edges.append(new_in_edges)
            all_new_out_edges.append(new_out_edges)

        for i in range(len(ccfg)):
            refined_ccfg[i].nid = i

            refined_ccfg[i].in_edges = []
            for src_idx, edgekind in all_new_in_edges[i]:
                refined_ccfg[i].in_edges.append(TCFGEdge(refined_ccfg[src_idx], refined_ccfg[i], edgekind))

            refined_ccfg[i].out_edges = []
            for dst_idx, edgekind in all_new_out_edges[i]:
                refined_ccfg[i].out_edges.append(TCFGEdge(refined_ccfg[i], refined_ccfg[dst_idx], edgekind))

            refined_ccfg[i].flags = 0

        return refined_ccfg

    def extract_ccfg(self, proc_name: str = None) -> tuple[tuple[TCFGNode, ...], ...]:
        """ Extract the code in critical area from TCFG. """
        global_stack = [self.nodes[0]]  # stack used for globally dfs TCFG
        res = []
        global_seen_nodes = []  # used to record traversed nodes in global dfs
        while global_stack:
            cur_node = global_stack.pop()
            if cur_node in global_seen_nodes:
                continue
            global_seen_nodes.append(cur_node)

            for edge in cur_node.out_edges:
                if edge.is_never_taken:
                    continue
                global_stack.append(edge.dst)

            if cur_node.bb.nid == 0 and \
                    cur_node.proc_name == "Disable_int":
                if proc_name != None \
                        and cur_node.in_edges != [] \
                        and [edge for edge in cur_node.in_edges if edge.src.proc_name == proc_name] == []:
                    continue

                local_stack = [cur_node]
                ccfg = []
                local_seen_nodes = []

                while local_stack:
                    cur_node_c = local_stack.pop()
                    if cur_node_c in local_seen_nodes:
                        continue
                    local_seen_nodes.append(cur_node_c)
                    ccfg.append(cur_node_c)

                    for edge_c in cur_node_c.out_edges:
                        if edge_c.is_never_taken:
                            continue
                        elif edge_c.is_ret and cur_node_c.proc_name == "Enable_int":
                            # stop when jumping out of critical area
                            continue
                        local_stack.append(edge_c.dst)

                res.append(self.refine_ccfg(ccfg))

        return tuple(res)

    def dump_fig(self, tcfg_nodes) -> graphviz.Digraph:
        dot = graphviz.Digraph('tcfg')
        for tn in tcfg_nodes:
            s = hex(tn.start_addr.to_dec())
            tail_ist = tn.bb.code[-1]
            e = hex(tail_ist.addr.to_dec())
            label = "%s\n%s - %s" % (tn.nid, s, e)
            if tn.dline:
                label += "\nline "
                if tn.dline[0][1] == tn.dline[-1][1]:
                    label += str(tn.dline[0][1])
                else:
                    label += "%s~%s" % (tn.dline[0][1], tn.dline[-1][1])
            if tn.bb.loop_role != LoopKind.LOOP_BODY:
                label += "\n%s" % tn.bb.loop_role
            dot.node(str(tn.nid), label=label,
                     style="filled", fillcolor="/set312/1",
                     xlabel=tn.proc_name)
            for edge in tn.out_edges:
                if edge.edge_kind == TCFGEdgeKind.CALL:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid), color='red')
                elif edge.edge_kind == TCFGEdgeKind.RET:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid), color='green')
                elif edge.edge_kind == TCFGEdgeKind.TAKEN:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid), color='darkgoldenrod1')
                elif edge.edge_kind == TCFGEdgeKind.NOT_TAKEN:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid))
                else:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid), style="dashed")
        return dot
