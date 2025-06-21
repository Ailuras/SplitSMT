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

(declare-sort var3430 0)
(declare-sort var149 0)
(declare-sort var1942 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1577871405 (var3430) String)
(declare-fun args/1577871405 (var3430) var149)
(declare-fun append/-1031950772 (String var1942) String)
(declare-fun cast-from-var149-to-var1942 (var149) var1942)
(declare-fun retvals/1577871405 (var3430) var149)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3430 var3430)
(declare-const null-var149 var149)
(declare-const var1481 var3430) ; Statement: r1 := @this: org.antlr.v4.tool.Rule 
(assert (not (= var1481 null-var3430)))
(define-const var1718 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1718)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1718!1 String)
(assert (= var1718!1 ""))
(assert true)
(define-const var1202 String (append/672562846 var1718!1 "Rule{name=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Rule{name=") 
(declare-const var1718!2 String)
(assert (= var1718!2 (str.++ var1718!1 "Rule{name=")))
(define-const var1566 String (name/1577871405 var1481)) ; Statement: $r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name> 
(assert true)
;(assert (append/672562846 var1202 var1566)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1202!1 String)
(assert (= var1202!1 (str.++ var1202 var1566)))
(define-const var562 var149 (args/1577871405 var1481)) ; Statement: $r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict args> 
 ; Statement: if $r4 == null goto $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals> 
(assert (not (= var562 null-var149))) ; Negate: Cond: $r4 == null  
(assert true)
(define-const var2983 String (append/672562846 var1718!2 ", args=")) ; Statement: $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", args=") 
(declare-const var1718!3 String)
(assert (= var1718!3 (str.++ var1718!2 ", args=")))
(define-const var2274 var149 (args/1577871405 var1481)) ; Statement: $r9 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict args> 
(assert true)
;(assert (append/-1031950772 var2983 (cast-from-var149-to-var1942 var2274))) ; Statement: virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var2983!1 String)
(assert (str.prefixof var2983 var2983!1))
(assert true) ; Non Conditional
(define-const var852 var149 (retvals/1577871405 var1481)) ; Statement: $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals> 
 ; Statement: if $r5 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(assert (= var852 null-var149)) ; Cond: $r5 == null 
(assert true)
;(assert (append/672562846 var1718!3 "}")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(declare-const var1718!4 String)
(assert (= var1718!4 (str.++ var1718!3 "}")))
(assert true)
(define-const var2038 String (toString/-2075883882 var1718!4)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1577871405=([org.antlr.v4.tool.Rule], java.lang.String), args/1577871405=([org.antlr.v4.tool.Rule], org.antlr.v4.tool.AttributeDict), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var149-to-var1942=([org.antlr.v4.tool.AttributeDict], java.lang.Object), retvals/1577871405=([org.antlr.v4.tool.Rule], org.antlr.v4.tool.AttributeDict), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3430=org.antlr.v4.tool.Rule, var1481=r1, var1718=$r0, var1202=$r3, var1566=$r2, var149=org.antlr.v4.tool.AttributeDict, var562=$r4, var2983=$r10, var2274=$r9, var1942=java.lang.Object, var852=$r5, var2038=$r6}
; {org.antlr.v4.tool.Rule=var3430, r1=var1481, $r0=var1718, $r3=var1202, $r2=var1566, org.antlr.v4.tool.AttributeDict=var149, $r4=var562, $r10=var2983, $r9=var2274, java.lang.Object=var1942, $r5=var852, $r6=var2038}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Rule;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Rule{name=");	$r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name>;	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict args>;	if $r4 == null goto $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals>;	$r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", args=");	$r9 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict args>;	virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals>;	if $r5 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 4