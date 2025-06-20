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

(declare-sort var2979 0)
(declare-sort var3715 0)
(declare-sort var604 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1577871405 (var2979) String)
(declare-fun args/1577871405 (var2979) var3715)
(declare-fun retvals/1577871405 (var2979) var3715)
(declare-fun append/-1031950772 (String var604) String)
(declare-fun cast-from-var3715-to-var604 (var3715) var604)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2979 var2979)
(declare-const null-var3715 var3715)
(declare-const var2154 var2979) ; Statement: r1 := @this: org.antlr.v4.tool.Rule 
(assert (not (= var2154 null-var2979)))
(define-const var1292 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1292)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1292!1 String)
(assert (= var1292!1 ""))
(assert true)
(define-const var1553 String (append/672562846 var1292!1 "Rule{name=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Rule{name=") 
(declare-const var1292!2 String)
(assert (= var1292!2 (str.++ var1292!1 "Rule{name=")))
(define-const var1264 String (name/1577871405 var2154)) ; Statement: $r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name> 
(assert true)
;(assert (append/672562846 var1553 var1264)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1553!1 String)
(assert (= var1553!1 (str.++ var1553 var1264)))
(define-const var3763 var3715 (args/1577871405 var2154)) ; Statement: $r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict args> 
 ; Statement: if $r4 == null goto $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals> 
(assert (= var3763 null-var3715)) ; Cond: $r4 == null 
(define-const var2957 var3715 (retvals/1577871405 var2154)) ; Statement: $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals> 
 ; Statement: if $r5 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(assert (not (= var2957 null-var3715))) ; Negate: Cond: $r5 == null  
(assert true)
(define-const var3857 String (append/672562846 var1292!2 ", retvals=")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", retvals=") 
(declare-const var1292!3 String)
(assert (= var1292!3 (str.++ var1292!2 ", retvals=")))
(define-const var2692 var3715 (retvals/1577871405 var2154)) ; Statement: $r7 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals> 
(assert true)
;(assert (append/-1031950772 var3857 (cast-from-var3715-to-var604 var2692))) ; Statement: virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7) 
(declare-const var3857!1 String)
(assert (str.prefixof var3857 var3857!1))
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var1292!3 "}")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(declare-const var1292!4 String)
(assert (= var1292!4 (str.++ var1292!3 "}")))
(assert true)
(define-const var3205 String (toString/-2075883882 var1292!4)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1577871405=([org.antlr.v4.tool.Rule], java.lang.String), args/1577871405=([org.antlr.v4.tool.Rule], org.antlr.v4.tool.AttributeDict), retvals/1577871405=([org.antlr.v4.tool.Rule], org.antlr.v4.tool.AttributeDict), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3715-to-var604=([org.antlr.v4.tool.AttributeDict], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2979=org.antlr.v4.tool.Rule, var2154=r1, var1292=$r0, var1553=$r3, var1264=$r2, var3715=org.antlr.v4.tool.AttributeDict, var3763=$r4, var2957=$r5, var3857=$r8, var2692=$r7, var604=java.lang.Object, var3205=$r6}
; {org.antlr.v4.tool.Rule=var2979, r1=var2154, $r0=var1292, $r3=var1553, $r2=var1264, org.antlr.v4.tool.AttributeDict=var3715, $r4=var3763, $r5=var2957, $r8=var3857, $r7=var2692, java.lang.Object=var604, $r6=var3205}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Rule;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Rule{name=");	$r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name>;	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict args>;	if $r4 == null goto $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals>;	$r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals>;	if $r5 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", retvals=");	$r7 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals>;	virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 4