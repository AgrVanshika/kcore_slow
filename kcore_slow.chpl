use List;
use IO; 
use Set;
use Sort;

config const file_path:string;

// These will not be global, we will have a function return them when done. 
// var nodes_list: list(int) = [1..35];
// var node_map: [1..nodes_list.size] int;
// var adjacency_list: [1..nodes_list.size] list(int);
var adjacency_list = build_graph_from_file(file_path);
var nodes_list = [1..adjacency_list.size];

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

proc build_graph_from_file(file_path:"graph.txt") {
        // Read in the file and create our file reader. 
        var file = open("graph.txt", ioMode.r);
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

proc removeNode(v: int) {
   adjacency_list[node_map[v]].clear();
   for u in 1..nodes_list.size {
     var idx = adjacency_list[u].find(node_map[v]);
     if idx > -1 {
       adjacency_list[u].getAndRemove(idx);
     }
   }
   nodes_list.remove(node_map[v]);
 }

proc degree(v: int): int {
     return adjacency_list[node_map[v]].size;
}

 proc k_core_slow() {
   var peel: int = 1;
   var Q: list(int);

   var Z: [1..nodes_list.size] list(int);
   var count = 0;
   while nodes_list.size > 0 {
     writeln("nodes_list.size value at the start ", nodes_list.size);
     count += 1;
     writeln("$$$$$ Iteration ", count, " $$$$$");
   
     // This will (almost) never be a regular array, since removing vertices can cause a irregular domain.
     var color: [1..nodes_list.size] bool;
     //var AD_color_domain = domain(int);
     //forall u in Z.domain()
 
     //color = false;
     var Vb: list(int);
     for v in 1..nodes_list.size {
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
