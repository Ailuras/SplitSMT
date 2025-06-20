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

(declare-sort var53 0)
(declare-sort var2066 0)
(declare-sort var1588 0)
(declare-sort var72 0)
(declare-sort var273 0)
(declare-sort var1824 0)
(declare-sort var3752 0)
(declare-sort var1573 0)
(declare-sort var1553 0)
(declare-sort var2319 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun name/-1662532433 (var53) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun pathCondition/-1662532433 (var53) var2066)
(declare-fun methodsCondition/-1662532433 (var53) var1588)
(declare-fun paramsCondition/-1662532433 (var53) var72)
(declare-fun headersCondition/-1662532433 (var53) var273)
(declare-fun consumesCondition/-1662532433 (var53) var1824)
(declare-fun producesCondition/-1662532433 (var53) var3752)
(declare-fun customCondition/-1662532433 (var53) var1573)
(declare-fun response/-1662532433 (var53) var1553)
(declare-fun cors/-1662532433 (var53) var2319)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var53 var53)
(declare-const null-var2066 var2066)
(declare-const null-var1588 var1588)
(declare-const null-var72 var72)
(declare-const null-var273 var273)
(declare-const null-var1824 var1824)
(declare-const null-var3752 var3752)
(declare-const null-var1573 var1573)
(declare-const null-var1553 var1553)
(declare-const null-var2319 var2319)
(declare-const var2598 var53) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping 
(assert (not (= var2598 null-var53)))
(define-const var1780 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var1780 "RequestMapping{name=\u0027")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RequestMapping{name=\'") 
(declare-const var1780!1 String)
(assert (= var1780!1 "RequestMapping{name=\u0027"))
(define-const var2443 String (name/-1662532433 var2598)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: java.lang.String name> 
(assert true)
(define-const var1801 String (append/672562846 var1780!1 var2443)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1780!2 String)
(assert (= var1780!2 (str.++ var1780!1 var2443)))
(assert true)
;(assert (append/-1166366385 var1801 39)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1801!1 String)
(assert (str.prefixof var1801 var1801!1))
(define-const var934 var2066 (pathCondition/-1662532433 var2598)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition> 
 ; Statement: if $r4 == null goto $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition> 
(assert (= var934 null-var2066)) ; Cond: $r4 == null 
(define-const var279 var1588 (methodsCondition/-1662532433 var2598)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition> 
 ; Statement: if $r5 == null goto $r6 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition paramsCondition> 
(assert (= var279 null-var1588)) ; Cond: $r5 == null 
(define-const var1008 var72 (paramsCondition/-1662532433 var2598)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition paramsCondition> 
 ; Statement: if $r6 == null goto $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition headersCondition> 
(assert (= var1008 null-var72)) ; Cond: $r6 == null 
(define-const var474 var273 (headersCondition/-1662532433 var2598)) ; Statement: $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition headersCondition> 
 ; Statement: if $r7 == null goto $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition consumesCondition> 
(assert (= var474 null-var273)) ; Cond: $r7 == null 
(define-const var2054 var1824 (consumesCondition/-1662532433 var2598)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition consumesCondition> 
 ; Statement: if $r8 == null goto $r9 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition producesCondition> 
(assert (= var2054 null-var1824)) ; Cond: $r8 == null 
(define-const var897 var3752 (producesCondition/-1662532433 var2598)) ; Statement: $r9 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition producesCondition> 
 ; Statement: if $r9 == null goto $r10 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConditionWrapper customCondition> 
(assert (= var897 null-var3752)) ; Cond: $r9 == null 
(define-const var27 var1573 (customCondition/-1662532433 var2598)) ; Statement: $r10 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConditionWrapper customCondition> 
 ; Statement: if $r10 == null goto $r11 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta response> 
(assert (= var27 null-var1573)) ; Cond: $r10 == null 
(define-const var3105 var1553 (response/-1662532433 var2598)) ; Statement: $r11 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta response> 
 ; Statement: if $r11 == null goto $r12 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta cors> 
(assert (= var3105 null-var1553)) ; Cond: $r11 == null 
(define-const var3292 var2319 (cors/-1662532433 var2598)) ; Statement: $r12 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta cors> 
 ; Statement: if $r12 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= var3292 null-var2319)) ; Cond: $r12 == null 
(assert true)
;(assert (append/-1166366385 var1780!2 125)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1780!3 String)
(assert (str.prefixof var1780!2 var1780!3))
(assert true)
(define-const var966 String (toString/-2075883882 var1780!3)) ; Statement: $r13 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), name/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), pathCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition), methodsCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition), paramsCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition), headersCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition), consumesCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition), producesCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition), customCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConditionWrapper), response/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta), cors/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var53=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var2598=r1, var1780=$r0, var2443=$r2, var1801=$r3, var2066=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition, var934=$r4, var1588=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition, var279=$r5, var72=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition, var1008=$r6, var273=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition, var474=$r7, var1824=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition, var2054=$r8, var3752=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition, var897=$r9, var1573=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConditionWrapper, var27=$r10, var1553=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta, var3105=$r11, var2319=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta, var3292=$r12, var966=$r13}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var53, r1=var2598, $r0=var1780, $r2=var2443, $r3=var1801, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition=var2066, $r4=var934, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition=var1588, $r5=var279, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition=var72, $r6=var1008, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition=var273, $r7=var474, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition=var1824, $r8=var2054, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition=var3752, $r9=var897, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConditionWrapper=var1573, $r10=var27, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta=var1553, $r11=var3105, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta=var2319, $r12=var3292, $r13=var966}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RequestMapping{name=\'");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: java.lang.String name>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition>;	if $r4 == null goto $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition>;	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition>;	if $r5 == null goto $r6 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition paramsCondition>;	$r6 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition paramsCondition>;	if $r6 == null goto $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition headersCondition>;	$r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition headersCondition>;	if $r7 == null goto $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition consumesCondition>;	$r8 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition consumesCondition>;	if $r8 == null goto $r9 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition producesCondition>;	$r9 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition producesCondition>;	if $r9 == null goto $r10 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConditionWrapper customCondition>;	$r10 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConditionWrapper customCondition>;	if $r10 == null goto $r11 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta response>;	$r11 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta response>;	if $r11 == null goto $r12 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta cors>;	$r12 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta cors>;	if $r12 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r13 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 10