/* sub_tree (Т2, Т1): дерево Т1 является непустым поддеревом дерева Т2 */

sub_tree(tree(L,R,M),tree(L,R,M)).
sub_tree(tree(L,R,_),T):-sub_tree(L,T);sub_tree(R,T).

/* sub_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),nil). = false */
/* sub_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),tree(tree(nil,nil,4),tree(nil,nil,1),3)). =true */
/* sub_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),tree(nil,tree(nil,nil,1),3)). = false */
/* sub_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),tree(nil,nil,2)). = false */