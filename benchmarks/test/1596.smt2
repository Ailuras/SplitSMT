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

(declare-sort var1376 0)
(declare-sort var3057 0)
(declare-sort var1935 0)
(declare-sort var1513 0)
(declare-sort var2012 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ruleCommands/-1071704734 (var1376) var1513)
(declare-fun var1513_add/328494887 (var1513 var2012) Bool)
(declare-fun cast-from-String-to-var2012 (String) var2012)
(declare-const null-var1376 var1376)
(declare-const null-String String)
(declare-const null-var1935 var1935)
(declare-const var445 var1376) ; Statement: r1 := @this: org.antlr.v4.automata.LexerATNFactory 
(assert (not (= var445 null-var1376)))
(declare-const var391 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var391 null-String)))
(declare-const var2096 var1935) ; Statement: r8 := @parameter1: org.antlr.runtime.Token 
(assert (not (= var2096 null-var1935)))
(assert true)
(define-const var3615 Bool (= var391 "pushMode")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("pushMode") 
 ; Statement: if $z0 != 0 goto $r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands> 
(assert (not (not (= (ite var3615 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(assert true)
(define-const var1337 Bool (= var391 "popMode")) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("popMode") 
 ; Statement: if $z1 != 0 goto $r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands> 
(assert (not (= (ite var1337 1 0) 0))) ; Cond: $z1 != 0 
(define-const var623 var1513 (ruleCommands/-1071704734 var445)) ; Statement: $r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands> 
;(assert (var1513_add/328494887 var623 (cast-from-String-to-var2012 var391))) ; Statement: interfaceinvoke $r27.<java.util.List: boolean add(java.lang.Object)>(r0) 

(declare-const var623!1 var1513)
(declare-const var391!1 String)
 ; Statement: return 
(check-sat)
; {ruleCommands/-1071704734=([org.antlr.v4.automata.LexerATNFactory], java.util.List), var1513_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var2012=([java.lang.String], java.lang.Object)}
; {var1376=org.antlr.v4.automata.LexerATNFactory, var445=r1, var391=r0, var3057=null_type, var1935=org.antlr.runtime.Token, var2096=r8, var3615=$z0, var1337=$z1, var1513=java.util.List, var623=$r27, var2012=java.lang.Object}
; {org.antlr.v4.automata.LexerATNFactory=var1376, r1=var445, r0=var391, null_type=var3057, org.antlr.runtime.Token=var1935, r8=var2096, $z0=var3615, $z1=var1337, java.util.List=var1513, $r27=var623, java.lang.Object=var2012}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r1 := @this: org.antlr.v4.automata.LexerATNFactory;	r0 := @parameter0: java.lang.String;	r8 := @parameter1: org.antlr.runtime.Token;	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("pushMode");	if $z0 != 0 goto $r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands>;	$z1 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("popMode");	if $z1 != 0 goto $r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands>;	$r27 = r1.<org.antlr.v4.automata.LexerATNFactory: java.util.List ruleCommands>;	interfaceinvoke $r27.<java.util.List: boolean add(java.lang.Object)>(r0);	return
;block_num 3