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

(declare-sort var182 0)
(declare-sort var2515 0)
(declare-sort var3201 0)
(declare-sort var2306 0)
(declare-sort var1778 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ruleCommands/-1071704734 (var182) var2306)
(declare-fun var2306_add/328494887 (var2306 var1778) Bool)
(declare-fun cast-from-String-to-var1778 (String) var1778)
(declare-const null-var182 var182)
(declare-const null-String String)
(declare-const null-var3201 var3201)
(declare-const var1902 var182) ; Statement: r1 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var1902 null-var182)))
(declare-const var3121 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3121 null-String)))
(declare-const var485 var3201) ; Statement: r8 := @parameter1: org.antlr.runtime.Token 
(assert (not (= var485 null-var3201)))
(assert true)
(define-const var3176 Bool (= var3121 "pushMode")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("pushMode") 
 ; Statement: if $z0 != 0 goto $r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands> 
(assert (not (= (ite var3176 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1302 var2306 (ruleCommands/-1071704734 var1902)) ; Statement: $r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands> 
;(assert (var2306_add/328494887 var1302 (cast-from-String-to-var1778 var3121))) ; Statement: interfaceinvoke $r27.<java.util.List: boolean add(java.lang.Object)>(r0) 

(declare-const var1302!1 var2306)
(declare-const var3121!1 String)
 ; Statement: return 
(check-sat)
; {ruleCommands/-1071704734=([org.antlr.v4.automata.LexerATNFactory], java.util.List), var2306_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var1778=([java.lang.String], java.lang.Object)}
; {var182=org.antlr.v4.automata.LexerATNFactory, var1902=r1, var3121=r0, var2515=null_type, var3201=org.antlr.runtime.Token, var485=r8, var3176=$z0, var2306=java.util.List, var1302=$r27, var1778=java.lang.Object}
; {org.antlr.v4.automata.LexerATNFactory=var182, r1=var1902, r0=var3121, null_type=var2515, org.antlr.runtime.Token=var3201, r8=var485, $z0=var3176, java.util.List=var2306, $r27=var1302, java.lang.Object=var1778}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: java.lang.String;	r8 := @parameter1: org.antlr.runtime.Token;	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("pushMode");	if $z0 != 0 goto $r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands>;	$r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands>;	interfaceinvoke $r27.<java.util.List: boolean add(java.lang.Object)>(r0);	return
;block_num 2