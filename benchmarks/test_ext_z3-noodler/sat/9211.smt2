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

(declare-sort var2692 0)
(declare-sort var3003 0)
(declare-sort var402 0)
(declare-sort var278 0)
(declare-sort var3375 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var402_getAttribute/147737434 (var2692 String) var3003)
(declare-fun cast-from-var3003-to-String (var3003) String)
(declare-fun var278_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3375-init () var3375)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var3375 String) void)
(declare-const null-var2692 var2692)
(declare-const null-ClassObject ClassObject)
(declare-const var1520 var2692) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var1520 null-var2692)))
(declare-const var3124 ClassObject) ; Statement: r4 := @parameter1: java.lang.Class 
(assert (not (= var3124 null-ClassObject)))
(define-const var2812 var3003 (var402_getAttribute/147737434 var1520 "interfaceName")) ; Statement: $r1 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>(r0, "interfaceName") 
(define-const var3465 String (cast-from-var3003-to-String var2812)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var2232 Bool (var278_hasText/853333513 (cast-from-String-to-String var3465))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>(r0, "interfaceClass") 
(assert (not (= (ite var2232 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2252 String "org.apache.dubbo.rpc.service.GenericService") ; Statement: $r15 = "org.apache.dubbo.rpc.service.GenericService" 
(assert true)
(define-const var2641 Bool (= var2252 var3465)) ; Statement: $z4 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z4 != 0 goto $r16 = new java.lang.IllegalStateException 
(assert (not (= (ite var2641 1 0) 0))) ; Cond: $z4 != 0 
(define-const var10 var3375 var3375-init) ; Statement: $r16 = new java.lang.IllegalStateException 
(define-const var2349 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2349)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2349!1 String)
(assert (= var2349!1 ""))
(assert true)
(define-const var346 String (append/672562846 var2349!1 "@Service interfaceName() cannot be GenericService: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@Service interfaceName() cannot be GenericService: ") 
(declare-const var2349!2 String)
(assert (= var2349!2 (str.++ var2349!1 "@Service interfaceName() cannot be GenericService: ")))
(assert true)
(define-const var1216 String (append/672562846 var346 var3465)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var346!1 String)
(assert (= var346!1 (str.++ var346 var3465)))
(assert true)
(define-const var497 String (toString/-2075883882 var1216)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var10 var497)) ; Statement: specialinvoke $r16.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r20) 

(declare-const var10!1 var3375)
(declare-const var497!1 String)
 ; Statement: throw $r16 
(check-sat)
; {var402_getAttribute/147737434=([java.util.Map, java.lang.String], java.lang.Object), cast-from-var3003-to-String=([java.lang.Object], java.lang.String), var278_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3375-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2692=java.util.Map, var1520=r0, var3124=r4, var3003=java.lang.Object, var402=org.apache.dubbo.config.spring.util.AnnotationUtils, var2812=$r1, var3465=r2, var278=org.apache.dubbo.common.utils.StringUtils, var2232=$z0, var2252=$r15, var2641=$z4, var3375=java.lang.IllegalStateException, var10=$r16, var2349=$r17, var346=$r18, var1216=$r19, var497=$r20}
; {java.util.Map=var2692, r0=var1520, r4=var3124, java.lang.Object=var3003, org.apache.dubbo.config.spring.util.AnnotationUtils=var402, $r1=var2812, r2=var3465, org.apache.dubbo.common.utils.StringUtils=var278, $z0=var2232, $r15=var2252, $z4=var2641, java.lang.IllegalStateException=var3375, $r16=var10, $r17=var2349, $r18=var346, $r19=var1216, $r20=var497}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.util.Map;	r4 := @parameter1: java.lang.Class;	$r1 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>(r0, "interfaceName");	r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r2);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>(r0, "interfaceClass");	$r15 = "org.apache.dubbo.rpc.service.GenericService";	$z4 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z4 != 0 goto $r16 = new java.lang.IllegalStateException;	$r16 = new java.lang.IllegalStateException;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@Service interfaceName() cannot be GenericService: ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r16.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r20);	throw $r16
;block_num 3