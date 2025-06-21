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

(declare-sort var790 0)
(declare-sort var3110 0)
(declare-sort var2628 0)
(declare-sort var2930 0)
(declare-sort var1792 0)
(declare-sort var1706 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getOperands/270673544 (var3110) var2930)
(declare-fun var2930_iterator/-1617794947 (var2930) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun Iterator_next/-1124697587 (Iterator) var1792)
(declare-fun cast-from-var1792-to-var1706 (var1792) var1706)
(declare-fun length/-171891354 (String) Int)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getSemanticContextDisplayString/534810451 (var790 var1706) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var790 var790)
(declare-const null-var3110 var3110)
(declare-const null-String String)
(declare-const var2208 var790) ; Statement: r7 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var2208 null-var790)))
(declare-const var2565 var3110) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.atn.SemanticContext$Operator 
(assert (not (= var2565 null-var3110)))
(declare-const var2559 String) ; Statement: r9 := @parameter1: java.lang.String 
(assert (not (= var2559 null-String)))
(define-const var1885 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1885)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1885!1 String)
(assert (= var1885!1 ""))
(assert true)
(define-const var2115 var2930 (getOperands/270673544 var2565)) ; Statement: $r2 = virtualinvoke r1.<org.antlr.v4.runtime.atn.SemanticContext$Operator: java.util.Collection getOperands()>() 
(define-const var2549 Iterator (var2930_iterator/-1617794947 var2115)) ; Statement: r3 = interfaceinvoke $r2.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2169 Bool (Iterator_hasNext/-1669924200 var2549)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (= (ite var2169 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2111 var1792 (Iterator_next/-1124697587 var2549)) ; Statement: $r5 = interfaceinvoke r3.<java.util.Iterator: java.lang.Object next()>() 
(declare-const var2549!1 Iterator)
(define-const var14 var1706 (cast-from-var1792-to-var1706 var2111)) ; Statement: r6 = (org.antlr.v4.runtime.atn.SemanticContext) $r5 
(assert true)
(define-const var3916 Int (length/-171891354 var1885!1)) ; Statement: $i0 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>() 
 ; Statement: if $i0 <= 0 goto $r8 = virtualinvoke r7.<org.antlr.v4.tool.Grammar: java.lang.String getSemanticContextDisplayString(org.antlr.v4.runtime.atn.SemanticContext)>(r6) 
(assert (not (<= var3916 0))) ; Negate: Cond: $i0 <= 0  
(assert true)
;(assert (append/672562846 var1885!1 var2559)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r9) 
(declare-const var1885!2 String)
(assert (= var1885!2 (str.++ var1885!1 var2559)))
(assert true) ; Non Conditional
(assert true)
(define-const var981 String (getSemanticContextDisplayString/534810451 var2208 var14)) ; Statement: $r8 = virtualinvoke r7.<org.antlr.v4.tool.Grammar: java.lang.String getSemanticContextDisplayString(org.antlr.v4.runtime.atn.SemanticContext)>(r6) 
(assert true)
;(assert (append/672562846 var1885!2 var981)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var1885!3 String)
(assert (= var1885!3 (str.++ var1885!2 var981)))
 ; Statement: goto [?= $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>()] 
(assert true) ; Non Conditional
(define-const var2169!1 Bool (Iterator_hasNext/-1669924200 var2549!1)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2169!1 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3490 String (toString/-2075883882 var1885!3)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getOperands/270673544=([org.antlr.v4.runtime.atn.SemanticContext$Operator], java.util.Collection), var2930_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), Iterator_next/-1124697587=([java.util.Iterator], java.lang.Object), cast-from-var1792-to-var1706=([java.lang.Object], org.antlr.v4.runtime.atn.SemanticContext), length/-171891354=([java.lang.StringBuilder], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getSemanticContextDisplayString/534810451=([org.antlr.v4.tool.Grammar, org.antlr.v4.runtime.atn.SemanticContext], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var790=org.antlr.v4.tool.Grammar, var2208=r7, var3110=org.antlr.v4.runtime.atn.SemanticContext$Operator, var2565=r1, var2559=r9, var2628=null_type, var1885=$r0, var2930=java.util.Collection, var2115=$r2, var2549=r3, var2169=$z0, var1792=java.lang.Object, var2111=$r5, var1706=org.antlr.v4.runtime.atn.SemanticContext, var14=r6, var3916=$i0, var981=$r8, var3490=$r4}
; {org.antlr.v4.tool.Grammar=var790, r7=var2208, org.antlr.v4.runtime.atn.SemanticContext$Operator=var3110, r1=var2565, r9=var2559, null_type=var2628, $r0=var1885, java.util.Collection=var2930, $r2=var2115, r3=var2549, $z0=var2169, java.lang.Object=var1792, $r5=var2111, org.antlr.v4.runtime.atn.SemanticContext=var1706, r6=var14, $i0=var3916, $r8=var981, $r4=var3490}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: int length()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: int length()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.antlr.v4.tool.Grammar;	r1 := @parameter0: org.antlr.v4.runtime.atn.SemanticContext$Operator;	r9 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.antlr.v4.runtime.atn.SemanticContext$Operator: java.util.Collection getOperands()>();	r3 = interfaceinvoke $r2.<java.util.Collection: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r5 = interfaceinvoke r3.<java.util.Iterator: java.lang.Object next()>();	r6 = (org.antlr.v4.runtime.atn.SemanticContext) $r5;	$i0 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>();	if $i0 <= 0 goto $r8 = virtualinvoke r7.<org.antlr.v4.tool.Grammar: java.lang.String getSemanticContextDisplayString(org.antlr.v4.runtime.atn.SemanticContext)>(r6);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r9);	$r8 = virtualinvoke r7.<org.antlr.v4.tool.Grammar: java.lang.String getSemanticContextDisplayString(org.antlr.v4.runtime.atn.SemanticContext)>(r6);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	goto [?= $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>()];	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 7