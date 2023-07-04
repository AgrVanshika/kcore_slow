use List;

var nv = 50;
var neighbor_complete: [1..nv] list(int);

proc initGraph() {
  for v in 1..nv {
    neighbor_complete[v] = new list(int);
  }
}

proc addEdge(u: int, v: int) {
  neighbor_complete[u].append(v);
  neighbor_complete[v].append(u);
}

proc removeNode(v: int) {
  neighbor_complete[v].clear();
  for u in 1..nv {
    var idx = neighbor_complete[u].find(v);
    if idx > -1 {
      neighbor_complete[u].pop(idx);
    }
  }
  nv -= 1;
}

proc degree(v: int): int {
  return neighbor_complete[v].size;
}

proc k_core_slow() {
  var peel: int = 2;
  var Q: list(int);
  var Z: [1..nv] list(int);

  while nv > 0 {
   // writeln("nv value at the start ", nv);
    var color: [1..nv] bool;
    color = false;
    var Vb: list(int);

    for v in 1..nv {
     // writeln("v in the for loop ", v);
      if degree(v) <= peel {
        color[v] = true;
        Vb.append(v);
      }
    }

    if Vb.size > 0 {
      var Eb: list((int, int));

      for u in 1..nv {
	//writeln("nv ", nv);
        for v in neighbor_complete[u] {
//	  writeln("u ", u);
//	  writeln("points to");
//	  writeln("v ", v);
          writeln("neighbour complete ", neighbor_complete[u]);
          writeln("color ", color[u]);
	  writeln("color[v]" , color[v]);
          writeln("Vb ", Vb);	  
          if (Vb.contains(u)) && (neighbor_complete[u].contains(v)) && color[u] && color[v] {
            Eb.append((u, v));
//	    writeln("Eb ", Eb);
          }
        
        }
      }

      for (u, v) in Eb {
        var idx1 = neighbor_complete[u].find(v);
        var idx2 = neighbor_complete[v].find(u);
        if idx1 > -1 {
          neighbor_complete[u].pop(idx1);
        }
        if idx2 > -1 {
          neighbor_complete[v].pop(idx2);
        }
      }

      for v in Vb {
  //      writeln("v being removed ", v);
        removeNode(v);
      }

      Q.append(Vb);
    } else {
      peel += 1;
      Q.clear();
    }
//    writeln("test");
  }

  // var induced_subgraph: list((int, int)) = [];
  var induced_subgraph: [1..nv] list(int);
  for v in 1..nv {
  induced_subgraph[v] = new list(int)();
  for u in neighbor_complete[v] {
    induced_subgraph[v].append(u);
    }
  }

//  var induced_subgraph: [1..nv] list(int);
  //for v in 1..nv {
    //for u in neighbor_complete[v] {
      //induced_subgraph[v].append(u);
    //}
 // }
  Z = Z[1..nv];
  return (induced_subgraph, peel);
}

initGraph();
addEdge(2, 1);
addEdge(3, 1);
addEdge(4, 1);
addEdge(5, 1);
addEdge(6, 1);
addEdge(7, 1);
addEdge(8, 1);
addEdge(9, 1);
addEdge(11, 1);
addEdge(12, 1);
addEdge(13, 1);
addEdge(14, 1);
addEdge(18, 1);
addEdge(20, 1);
addEdge(22, 1);
addEdge(31, 1);
addEdge(4, 3);
addEdge(8, 3);
addEdge(9, 3);
addEdge(10, 3);
addEdge(14, 3);
addEdge(28, 3);
addEdge(29, 3);
addEdge(33, 3);
addEdge(8, 4);
addEdge(13, 4);
addEdge(14, 4);
addEdge(7, 5);
addEdge(11, 5);
addEdge(7, 6);
addEdge(11, 6);
addEdge(17, 6);
addEdge(17, 7);
addEdge(31, 9);
addEdge(33, 9);
addEdge(34, 9);
addEdge(34, 10);
addEdge(34, 14);
addEdge(33, 15);
addEdge(34, 15);
addEdge(33, 16);
addEdge(34, 16);
addEdge(33, 19);
addEdge(34, 19);
addEdge(34, 20);
addEdge(33, 21);
addEdge(34, 21);
addEdge(33, 23);
addEdge(34, 23);
addEdge(26, 24);
addEdge(28, 24);
addEdge(30, 24);
addEdge(33, 24);
addEdge(34, 24);
addEdge(26, 25);
addEdge(28, 25);
addEdge(32, 25);
addEdge(32, 26);
addEdge(30, 27);
addEdge(34, 27);
addEdge(32, 29);
addEdge(34, 29);
addEdge(33, 30);
addEdge(34, 30);
addEdge(33, 31);
addEdge(34, 31);
addEdge(33, 32);
addEdge(34, 32);
addEdge(34, 33);

var (Z, peel) = k_core_slow();

writeln("Induced Subgraph:");
for u in Z.domain {
  for v in Z[u] {
    writeln("(", u, ", ", v, ")");
  }
}
writeln("Peel value:", peel);
