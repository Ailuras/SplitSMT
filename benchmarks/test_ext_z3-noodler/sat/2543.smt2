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

(declare-sort var3365 0)
(declare-sort var574 0)
(declare-sort var1135 0)
(declare-sort var1121 0)
(declare-sort var2309 0)
(declare-sort var2350 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getOperands/270673544 (var574) var1121)
(declare-fun var1121_iterator/-1617794947 (var1121) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun Iterator_next/-1124697587 (Iterator) var2309)
(declare-fun cast-from-var2309-to-var2350 (var2309) var2350)
(declare-fun length/-171891354 (String) Int)
(declare-fun getSemanticContextDisplayString/534810451 (var3365 var2350) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3365 var3365)
(declare-const null-var574 var574)
(declare-const null-String String)
(declare-const var3218 var3365) ; Statement: r7 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var3218 null-var3365)))
(declare-const var329 var574) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.atn.SemanticContext$Operator 
(assert (not (= var329 null-var574)))
(declare-const var1354 String) ; Statement: r9 := @parameter1: java.lang.String 
(assert (not (= var1354 null-String)))
(define-const var3722 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3722)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3722!1 String)
(assert (= var3722!1 ""))
(assert true)
(define-const var3324 var1121 (getOperands/270673544 var329)) ; Statement: $r2 = virtualinvoke r1.<org.antlr.v4.runtime.atn.SemanticContext$Operator: java.util.Collection getOperands()>() 
(define-const var1489 Iterator (var1121_iterator/-1617794947 var3324)) ; Statement: r3 = interfaceinvoke $r2.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var367 Bool (Iterator_hasNext/-1669924200 var1489)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (= (ite var367 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2826 var2309 (Iterator_next/-1124697587 var1489)) ; Statement: $r5 = interfaceinvoke r3.<java.util.Iterator: java.lang.Object next()>() 
(declare-const var1489!1 Iterator)
(define-const var3020 var2350 (cast-from-var2309-to-var2350 var2826)) ; Statement: r6 = (org.antlr.v4.runtime.atn.SemanticContext) $r5 
(assert true)
(define-const var2060 Int (length/-171891354 var3722!1)) ; Statement: $i0 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>() 
 ; Statement: if $i0 <= 0 goto $r8 = virtualinvoke r7.<org.antlr.v4.tool.Grammar: java.lang.String getSemanticContextDisplayString(org.antlr.v4.runtime.atn.SemanticContext)>(r6) 
(assert (<= var2060 0)) ; Cond: $i0 <= 0 
(assert true)
(define-const var2120 String (getSemanticContextDisplayString/534810451 var3218 var3020)) ; Statement: $r8 = virtualinvoke r7.<org.antlr.v4.tool.Grammar: java.lang.String getSemanticContextDisplayString(org.antlr.v4.runtime.atn.SemanticContext)>(r6) 
(assert true)
;(assert (append/672562846 var3722!1 var2120)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var3722!2 String)
(assert (= var3722!2 (str.++ var3722!1 var2120)))
 ; Statement: goto [?= $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>()] 
(assert true) ; Non Conditional
(define-const var367!1 Bool (Iterator_hasNext/-1669924200 var1489!1)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var367!1 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var433 String (toString/-2075883882 var3722!2)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getOperands/270673544=([org.antlr.v4.runtime.atn.SemanticContext$Operator], java.util.Collection), var1121_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), Iterator_next/-1124697587=([java.util.Iterator], java.lang.Object), cast-from-var2309-to-var2350=([java.lang.Object], org.antlr.v4.runtime.atn.SemanticContext), length/-171891354=([java.lang.StringBuilder], int), getSemanticContextDisplayString/534810451=([org.antlr.v4.tool.Grammar, org.antlr.v4.runtime.atn.SemanticContext], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3365=org.antlr.v4.tool.Grammar, var3218=r7, var574=org.antlr.v4.runtime.atn.SemanticContext$Operator, var329=r1, var1354=r9, var1135=null_type, var3722=$r0, var1121=java.util.Collection, var3324=$r2, var1489=r3, var367=$z0, var2309=java.lang.Object, var2826=$r5, var2350=org.antlr.v4.runtime.atn.SemanticContext, var3020=r6, var2060=$i0, var2120=$r8, var433=$r4}
; {org.antlr.v4.tool.Grammar=var3365, r7=var3218, org.antlr.v4.runtime.atn.SemanticContext$Operator=var574, r1=var329, r9=var1354, null_type=var1135, $r0=var3722, java.util.Collection=var1121, $r2=var3324, r3=var1489, $z0=var367, java.lang.Object=var2309, $r5=var2826, org.antlr.v4.runtime.atn.SemanticContext=var2350, r6=var3020, $i0=var2060, $r8=var2120, $r4=var433}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: int length()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: int length()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.antlr.v4.tool.Grammar;	r1 := @parameter0: org.antlr.v4.runtime.atn.SemanticContext$Operator;	r9 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.antlr.v4.runtime.atn.SemanticContext$Operator: java.util.Collection getOperands()>();	r3 = interfaceinvoke $r2.<java.util.Collection: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r5 = interfaceinvoke r3.<java.util.Iterator: java.lang.Object next()>();	r6 = (org.antlr.v4.runtime.atn.SemanticContext) $r5;	$i0 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>();	if $i0 <= 0 goto $r8 = virtualinvoke r7.<org.antlr.v4.tool.Grammar: java.lang.String getSemanticContextDisplayString(org.antlr.v4.runtime.atn.SemanticContext)>(r6);	$r8 = virtualinvoke r7.<org.antlr.v4.tool.Grammar: java.lang.String getSemanticContextDisplayString(org.antlr.v4.runtime.atn.SemanticContext)>(r6);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	goto [?= $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>()];	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 6