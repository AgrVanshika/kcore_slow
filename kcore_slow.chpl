use List;
use IO; 
use Set;
use Sort;

config const file_path:string;

// These will not be global, we will have a function return them when done. 
// var nodes_list: list(int) = [1..35];
// var node_map: [1..nodes_list.size] int;
// var adjacency_list: [1..nodes_list.size] list(int);

// FOR NEXT WEEK:
// 1. Change adjacency_list to a more change-friendly format. Preferably using IDEA 1 below. 
// 2. Fix kcore code based off new data structure change. 

// IDEA 1: normalization of node names
// Say we have a graph with irregular range node names such as [5, 1, 7, 34] (this is nodes_list for IDEA 2).
// We can assign an "internal" node value as a node map. How?
// Step 1: sort the node names to [1, 5, 7, 34] and then make the INDEX the name of the nodes. 
// [1, 5, 7, 34]
// [0, 1, 2,  3] 
// Step 2: And then we make our adjacency_list array using this domain instead of 1..nodes_list.size
// Step 3: Change all edge endpoints to the normalized range. 

// IDEA 2: just make an associative domain to hold index values. 
// var AD_adjacency_list = domain(int);
// for u in nodes_list do AD_adjacency_list += u; 
// var adjacency_list : [AD_adjacency_list] list(int);

// proc initGraph() {
//   nodes_list.sort();
//   writeln("nodes_list.sort() ", nodes_list);
//   for i in 1..nodes_list.size-1 {
//     writeln(i);
//     writeln(node_map);
//     node_map[nodes_list[i]] = i;
//   }
  
//   for v in 1..nodes_list.size {
//     adjacency_list[v] = new list(int);
//   }
// }

proc build_graph_from_file(file_path:string) {
        // Read in the file and create our file reader. 
        var file = open(file_path, ioMode.r);
        var file_reader = file.reader();
        
        // Initialize line variable to hold line during file reading. 
        var line : string;

        // Read in the graph file to discover how many vertices we are working with. 
        var vertex_set = new set(int, parSafe=false);
        while(file_reader.readLine(line)) {
            var edge = line.split();
            writeln(edge);
            vertex_set.add(edge[0]:int);
            vertex_set.add(edge[1]:int);
        }
        file.close();
        file_reader.close();
        writeln("vertex_set = ", vertex_set);
        var vertex_array = vertex_set.toArray();
        writeln("vertex_array = ", vertex_array);
        sort(vertex_array); 
        writeln("vertex_array = ", vertex_array);

        var D_vertex_array_rev : domain(int);
        for u in vertex_array do D_vertex_array_rev += u;
        var vertex_array_rev : [D_vertex_array_rev] int;
        for (u,i) in zip(vertex_array, vertex_array.domain) do vertex_array_rev[u] = i;
        writeln("vertex_array_rev = ", vertex_array_rev);

        // Read in the graph file again, but this time we will build our adjacency list.
        var D_adjacency_list = vertex_array.domain;
        var adjacency_list : [D_adjacency_list] list(int);
        writeln("D_adjacency_list = ", D_adjacency_list);
        file = open(file_path, ioMode.r);
        file_reader = file.reader();
        while(file_reader.readLine(line)) {
            var edge = line.split();
            writeln(edge);
            var u = edge[0]:int;
            var v = edge[1]:int;

            adjacency_list[vertex_array_rev[u]].pushBack(vertex_array_rev[v]);
            adjacency_list[vertex_array_rev[v]].pushBack(vertex_array_rev[u]);
        }
        writeln(adjacency_list);

        return adjacency_list;
}

// COMMENT BACK IN: the stuff that does kcore_slow and remove node and finding degrees. 
// NOT NEEDED: anything marked not needed. 
// TODO FROM 4/17: understand the graph reading function above, get kcore_slow working, and clean up file :). 



// NOT NEEDED: we will read graph in from a file. 
// proc addEdge(u: int, v: int) {
//   writeln("Added ", u , " here");
//   writeln("nodes_list is ", nodes_list);
//   adjacency_list[node_map[u]].pushBack(node_map[v]);
//   adjacency_list[node_map[v]].pushBack(node_map[u]);
// }

// proc removeNode(v: int) {
//   adjacency_list[node_map[v]].clear();
//   for u in 1..nodes_list.size {
//     var idx = adjacency_list[u].find(node_map[v]);
//     if idx > -1 {
//       adjacency_list[u].getAndRemove(idx);
//     }
//   }
//   nodes_list.remove(node_map[v]);
// }

// proc degree(v: int): int {
//   return adjacency_list[node_map[v]].size;
// }

// proc k_core_slow() {
//   var peel: int = 1;
//   var Q: list(int);
  
//   var Z: [1..nodes_list.size] list(int);

//   var count = 0;
//   while nodes_list.size > 0 {
//     writeln("nodes_list.size value at the start ", nodes_list.size);
//     count += 1;
//     writeln("$$$$$ Iteration ", count, " $$$$$");
    
//     // This will (almost) never be a regular array, since removing vertices can cause a irregular domain.
//     var color: [1..nodes_list.size] bool;
//     //var AD_color_domain = domain(int);
//     //forall u in Z.domain()
    
//     //color = false;
//     var Vb: list(int);

//     for v in 1..nodes_list.size {
//       writeln("v in the for loop ", v);
//       if degree(v) <= peel {
//         color[v] = true;
//         Vb.pushBack(v);
//       }
//     }

//     if Vb.size > 0 {
//       var Eb: list((int, int));

//       for u in 1..nodes_list.size {
// 	    //writeln("nodes_list.size ", nodes_list.size);
//         for v in adjacency_list[u] {
//       	  writeln("u ", u);
//       	  writeln("points to");
//       	  writeln("v ", v);
//           writeln("neighbour complete for ", u, ": ", adjacency_list[u]);
//           writeln("color for ", u, ": ", color[u]);
// 	        writeln("color domain = ", color.domain);
//           writeln("color for ", v, ": ", color[v]); 
//           writeln("Vb ", Vb);
//           if (Vb.contains(u)) && (adjacency_list[u].contains(v)) && color[u] && color[v] {
//             Eb.pushBack((u, v));
//       	   writeln("Eb ", Eb);
//           }      
//         }
//       }

//       for (u, v) in Eb {
//         var idx1 = adjacency_list[u].find(v);
//         var idx2 = adjacency_list[v].find(u);
//         if idx1 > -1 {
//           adjacency_list[u].getAndRemove(idx1);
//         }
//         if idx2 > -1 {
//           adjacency_list[v].getAndRemove(idx2);
//         }
//       }

//       for v in Vb {
//         writeln("v being removed ", v);
//         removeNode(v);
//       }

//       Q.pushBack(Vb);
//     } else {
//       peel += 1;
//       Q.clear();
//     }
// //    writeln("test");
// writeln();
//   }

//   // var induced_subgraph: list((int, int)) = [];
//   var induced_subgraph: [1..nodes_list.size] list(int);
//   for v in 1..nodes_list.size {
//   induced_subgraph[v] = new list(int)();
//   for u in adjacency_list[v] {
//     induced_subgraph[v].pushBack(u);
//     }
//   }
//   return (induced_subgraph, peel);

//  var induced_subgraph: [1..nodes_list.size] list(int);
  //for v in 1..nodes_list.size {
    //for u in adjacency_list[v] {
      //induced_subgraph[v].pushBack(u);
    //}
 // }
//   Z = Z[1..nodes_list.size];
  
// }

// initGraph();
// NOT NEEDED: an addEdge() function is usually only for dynamic graphs... not our use case. 
// addEdge(2, 1);
// addEdge(3, 1);
// addEdge(4, 1);
// addEdge(5, 1);
// addEdge(6, 1);
// addEdge(7, 1);
// addEdge(8, 1);
// addEdge(9, 1);
// addEdge(11, 1);
// addEdge(12, 1);
// addEdge(13, 1);
// addEdge(14, 1);
// addEdge(18, 1);
// addEdge(20, 1);
// addEdge(22, 1);
// addEdge(31, 1);
// addEdge(4, 3);
// addEdge(8, 3);
// addEdge(9, 3);
// addEdge(10, 3);
// addEdge(14, 3);
// addEdge(28, 3);
// addEdge(29, 3);
// addEdge(33, 3);
// addEdge(8, 4);
// addEdge(13, 4);
// addEdge(14, 4);
// addEdge(7, 5);
// addEdge(11, 5);
// addEdge(7, 6);
// addEdge(11, 6);
// addEdge(17, 6);
// addEdge(17, 7);
// addEdge(31, 9);
// addEdge(33, 9);
// addEdge(34, 9);
// addEdge(34, 10);
// addEdge(34, 14);
// addEdge(33, 15);
// addEdge(34, 15);
// addEdge(33, 16);
// addEdge(34, 16);
// addEdge(33, 19);
// addEdge(34, 19);
// addEdge(34, 20);
// addEdge(33, 21);
// addEdge(34, 21);
// addEdge(33, 23);
// addEdge(34, 23);
// addEdge(26, 24);
// addEdge(28, 24);
// addEdge(30, 24);
// addEdge(33, 24);
// addEdge(34, 24);
// addEdge(26, 25);
// addEdge(28, 25);
// addEdge(32, 25);
// addEdge(32, 26);
// addEdge(30, 27);
// addEdge(34, 27);
// addEdge(32, 29);
// addEdge(34, 29);
// addEdge(33, 30);
// addEdge(34, 30);
// addEdge(33, 31);
// addEdge(34, 31);
// addEdge(33, 32);
// addEdge(34, 32);
// addEdge(34, 33);


var graph_adjacency_list = build_graph_from_file(file_path);

// COMMENTED OUT TEMPORARILY SO WE CAN GET GRAPH BUILDING FUNCTION COMPLETE.
// var (Z, peel) = k_core_slow();

// writeln("Induced Subgraph:");
// for u in Z.domain {
//   for v in Z[u] {
//     writeln("(", u, ", ", v, ")");
//   }
// }
// writeln("Peel value:", peel);
