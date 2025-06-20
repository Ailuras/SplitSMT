(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2951 0)
(declare-sort var3903 0)
(declare-sort var891 0)
(declare-sort var2581 0)
(declare-sort var3855 0)
(declare-sort var1426 0)
(declare-sort var203 0)
(declare-sort var1245 0)
(declare-sort var1327 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun token/-354376 (var891) var3903)
(declare-fun cast-from-var2951-to-var891 (var2951) var891)
(declare-fun var3903_getInputStream/-1985324798 (var3903) var2581)
(declare-fun var3855-init () var3855)
(declare-fun <init>/1066337186 (var3855 var2581) void)
(declare-fun var1426-init () var1426)
(declare-fun cast-from-var3855-to-var203 (var3855) var203)
(declare-fun <init>/503496782 (var1426 var203 var1245) void)
(declare-fun cast-from-var2951-to-var1245 (var2951) var1245)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun LT/1979035213 (var1426 Int) var1245)
(declare-fun cast-from-var1245-to-var2951 (var1245) var2951)
(declare-fun getType/-1475907616 (var1327 var1245) Int)
(declare-fun cast-from-var3855-to-var1327 (var3855) var1327)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2951 var2951)
(declare-const var2458 var2951) ; Statement: r0 := @this: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var2458 null-var2951)))
(define-const var805 var3903 (token/-354376 (cast-from-var2951-to-var891 var2458))) ; Statement: $r1 = r0.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token token> 
(define-const var1670 var2581 (var3903_getInputStream/-1985324798 var805)) ; Statement: r2 = interfaceinvoke $r1.<org.antlr.runtime.Token: org.antlr.runtime.CharStream getInputStream()>() 
(define-const var1593 var3855 var3855-init) ; Statement: $r11 = new org.antlr.v4.parse.GrammarASTAdaptor 
(assert true)
;(assert (<init>/1066337186 var1593 var1670)) ; Statement: specialinvoke $r11.<org.antlr.v4.parse.GrammarASTAdaptor: void <init>(org.antlr.runtime.CharStream)>(r2) 

(declare-const var1593!1 var3855)
(declare-const var1670!1 var2581)
(define-const var1740 var1426 var1426-init) ; Statement: $r12 = new org.antlr.runtime.tree.CommonTreeNodeStream 
(define-const var1625 var203 (cast-from-var3855-to-var203 var1593!1)) ; Statement: $r14 = (org.antlr.runtime.tree.TreeAdaptor) $r11 
(assert true)
;(assert (<init>/503496782 var1740 var1625 (cast-from-var2951-to-var1245 var2458))) ; Statement: specialinvoke $r12.<org.antlr.runtime.tree.CommonTreeNodeStream: void <init>(org.antlr.runtime.tree.TreeAdaptor,java.lang.Object)>($r14, r0) 

(declare-const var1740!1 var1426)
(declare-const var1625!1 var203)
(declare-const var2458!1 var2951)
(define-const var3200 String String-init) ; Statement: $r13 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3200)) ; Statement: specialinvoke $r13.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3200!1 String)
(assert (= var3200!1 ""))
(assert true)
(define-const var3121 var1245 (LT/1979035213 var1740!1 1)) ; Statement: $r6 = virtualinvoke $r12.<org.antlr.runtime.tree.CommonTreeNodeStream: java.lang.Object LT(int)>(1) 
(define-const var2796 var2951 (cast-from-var1245-to-var2951 var3121)) ; Statement: r10 = (org.antlr.v4.tool.ast.GrammarAST) $r6 
(assert true)
(define-const var3286 Int (getType/-1475907616 (cast-from-var3855-to-var1327 var1593!1) (cast-from-var2951-to-var1245 var2796))) ; Statement: i0 = virtualinvoke $r11.<org.antlr.v4.parse.GrammarASTAdaptor: int getType(java.lang.Object)>(r10) 
(assert true) ; Non Conditional
(define-const var1314 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
 ; Statement: if i0 == $i2 goto $r7 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var3286 var1314)) ; Cond: i0 == $i2 
(assert true)
(define-const var2805 String (toString/-2075883882 var3200!1)) ; Statement: $r7 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {token/-354376=([org.antlr.runtime.tree.CommonTree], org.antlr.runtime.Token), cast-from-var2951-to-var891=([org.antlr.v4.tool.ast.GrammarAST], org.antlr.runtime.tree.CommonTree), var3903_getInputStream/-1985324798=([org.antlr.runtime.Token], org.antlr.runtime.CharStream), var3855-init=([], org.antlr.v4.parse.GrammarASTAdaptor), <init>/1066337186=([org.antlr.v4.parse.GrammarASTAdaptor, org.antlr.runtime.CharStream], void), var1426-init=([], org.antlr.runtime.tree.CommonTreeNodeStream), cast-from-var3855-to-var203=([org.antlr.v4.parse.GrammarASTAdaptor], org.antlr.runtime.tree.TreeAdaptor), <init>/503496782=([org.antlr.runtime.tree.CommonTreeNodeStream, org.antlr.runtime.tree.TreeAdaptor, java.lang.Object], void), cast-from-var2951-to-var1245=([org.antlr.v4.tool.ast.GrammarAST], java.lang.Object), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), LT/1979035213=([org.antlr.runtime.tree.CommonTreeNodeStream, int], java.lang.Object), cast-from-var1245-to-var2951=([java.lang.Object], org.antlr.v4.tool.ast.GrammarAST), getType/-1475907616=([org.antlr.runtime.tree.CommonTreeAdaptor, java.lang.Object], int), cast-from-var3855-to-var1327=([org.antlr.v4.parse.GrammarASTAdaptor], org.antlr.runtime.tree.CommonTreeAdaptor), cast-from-Int-to-Int=([int], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2951=org.antlr.v4.tool.ast.GrammarAST, var2458=r0, var3903=org.antlr.runtime.Token, var891=org.antlr.runtime.tree.CommonTree, var805=$r1, var2581=org.antlr.runtime.CharStream, var1670=r2, var3855=org.antlr.v4.parse.GrammarASTAdaptor, var1593=$r11, var1426=org.antlr.runtime.tree.CommonTreeNodeStream, var1740=$r12, var203=org.antlr.runtime.tree.TreeAdaptor, var1625=$r14, var1245=java.lang.Object, var3200=$r13, var3121=$r6, var2796=r10, var1327=org.antlr.runtime.tree.CommonTreeAdaptor, var3286=i0, var1314=$i2, var2805=$r7}
; {org.antlr.v4.tool.ast.GrammarAST=var2951, r0=var2458, org.antlr.runtime.Token=var3903, org.antlr.runtime.tree.CommonTree=var891, $r1=var805, org.antlr.runtime.CharStream=var2581, r2=var1670, org.antlr.v4.parse.GrammarASTAdaptor=var3855, $r11=var1593, org.antlr.runtime.tree.CommonTreeNodeStream=var1426, $r12=var1740, org.antlr.runtime.tree.TreeAdaptor=var203, $r14=var1625, java.lang.Object=var1245, $r13=var3200, $r6=var3121, r10=var2796, org.antlr.runtime.tree.CommonTreeAdaptor=var1327, i0=var3286, $i2=var1314, $r7=var2805}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.antlr.v4.tool.ast.GrammarAST;	$r1 = r0.<org.antlr.v4.tool.ast.GrammarAST: org.antlr.runtime.Token token>;	r2 = interfaceinvoke $r1.<org.antlr.runtime.Token: org.antlr.runtime.CharStream getInputStream()>();	$r11 = new org.antlr.v4.parse.GrammarASTAdaptor;	specialinvoke $r11.<org.antlr.v4.parse.GrammarASTAdaptor: void <init>(org.antlr.runtime.CharStream)>(r2);	$r12 = new org.antlr.runtime.tree.CommonTreeNodeStream;	$r14 = (org.antlr.runtime.tree.TreeAdaptor) $r11;	specialinvoke $r12.<org.antlr.runtime.tree.CommonTreeNodeStream: void <init>(org.antlr.runtime.tree.TreeAdaptor,java.lang.Object)>($r14, r0);	$r13 = new java.lang.StringBuilder;	specialinvoke $r13.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r12.<org.antlr.runtime.tree.CommonTreeNodeStream: java.lang.Object LT(int)>(1);	r10 = (org.antlr.v4.tool.ast.GrammarAST) $r6;	i0 = virtualinvoke $r11.<org.antlr.v4.parse.GrammarASTAdaptor: int getType(java.lang.Object)>(r10);	$i2 = (int) -1;	if i0 == $i2 goto $r7 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 3