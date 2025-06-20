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

(declare-sort var2051 0)
(declare-sort var2328 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1577871405 (var2051) String)
(declare-fun args/1577871405 (var2051) var2328)
(declare-fun retvals/1577871405 (var2051) var2328)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2051 var2051)
(declare-const null-var2328 var2328)
(declare-const var3960 var2051) ; Statement: r1 := @this: org.antlr.v4.tool.Rule 
(assert (not (= var3960 null-var2051)))
(define-const var2429 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2429)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2429!1 String)
(assert (= var2429!1 ""))
(assert true)
(define-const var3821 String (append/672562846 var2429!1 "Rule{name=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Rule{name=") 
(declare-const var2429!2 String)
(assert (= var2429!2 (str.++ var2429!1 "Rule{name=")))
(define-const var3633 String (name/1577871405 var3960)) ; Statement: $r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name> 
(assert true)
;(assert (append/672562846 var3821 var3633)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3821!1 String)
(assert (= var3821!1 (str.++ var3821 var3633)))
(define-const var3434 var2328 (args/1577871405 var3960)) ; Statement: $r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict args> 
 ; Statement: if $r4 == null goto $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals> 
(assert (= var3434 null-var2328)) ; Cond: $r4 == null 
(define-const var230 var2328 (retvals/1577871405 var3960)) ; Statement: $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals> 
 ; Statement: if $r5 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(assert (= var230 null-var2328)) ; Cond: $r5 == null 
(assert true)
;(assert (append/672562846 var2429!2 "}")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(declare-const var2429!3 String)
(assert (= var2429!3 (str.++ var2429!2 "}")))
(assert true)
(define-const var463 String (toString/-2075883882 var2429!3)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1577871405=([org.antlr.v4.tool.Rule], java.lang.String), args/1577871405=([org.antlr.v4.tool.Rule], org.antlr.v4.tool.AttributeDict), retvals/1577871405=([org.antlr.v4.tool.Rule], org.antlr.v4.tool.AttributeDict), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2051=org.antlr.v4.tool.Rule, var3960=r1, var2429=$r0, var3821=$r3, var3633=$r2, var2328=org.antlr.v4.tool.AttributeDict, var3434=$r4, var230=$r5, var463=$r6}
; {org.antlr.v4.tool.Rule=var2051, r1=var3960, $r0=var2429, $r3=var3821, $r2=var3633, org.antlr.v4.tool.AttributeDict=var2328, $r4=var3434, $r5=var230, $r6=var463}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Rule;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Rule{name=");	$r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name>;	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict args>;	if $r4 == null goto $r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals>;	$r5 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.AttributeDict retvals>;	if $r5 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 3