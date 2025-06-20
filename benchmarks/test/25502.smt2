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

(declare-sort var299 0)
(declare-sort var2829 0)
(declare-sort var2291 0)
(declare-sort var3712 0)
(declare-sort var3569 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun mapping/1013546832 (var299) var2829)
(declare-fun append/-1031950772 (String var2291) String)
(declare-fun cast-from-var2829-to-var2291 (var2829) var2291)
(declare-fun meta/1013546832 (var299) var3712)
(declare-fun getMethod/1408216999 (var3712) var3569)
(declare-fun cast-from-var3569-to-var2291 (var3569) var2291)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var299 var299)
(declare-const var2566 var299) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration 
(assert (not (= var2566 null-var299)))
(define-const var3366 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3366)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3366!1 String)
(assert (= var3366!1 ""))
(assert true)
(define-const var539 String (append/672562846 var3366!1 "Registration{mapping=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Registration{mapping=") 
(declare-const var3366!2 String)
(assert (= var3366!2 (str.++ var3366!1 "Registration{mapping=")))
(define-const var2775 var2829 (mapping/1013546832 var2566)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping mapping> 
(assert true)
(define-const var2945 String (append/-1031950772 var539 (cast-from-var2829-to-var2291 var2775))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var539!1 String)
(assert (str.prefixof var539 var539!1))
(assert true)
(define-const var1625 String (append/672562846 var2945 ", method=")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method=") 
(declare-const var2945!1 String)
(assert (= var2945!1 (str.++ var2945 ", method=")))
(define-const var377 var3712 (meta/1013546832 var2566)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta meta> 
(assert true)
(define-const var3247 var3569 (getMethod/1408216999 var377)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta getMethod()>() 
(assert true)
(define-const var3463 String (append/-1031950772 var1625 (cast-from-var3569-to-var2291 var3247))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var1625!1 String)
(assert (str.prefixof var1625 var1625!1))
(assert true)
(define-const var1470 String (append/-1166366385 var3463 125)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3463!1 String)
(assert (str.prefixof var3463 var3463!1))
(assert true)
(define-const var3571 String (toString/-2075883882 var1470)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), mapping/1013546832=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2829-to-var2291=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], java.lang.Object), meta/1013546832=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta), getMethod/1408216999=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta), cast-from-var3569-to-var2291=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var299=org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration, var2566=r1, var3366=$r0, var539=$r3, var2829=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var2775=$r2, var2291=java.lang.Object, var2945=$r4, var1625=$r7, var3712=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta, var377=$r5, var3569=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta, var3247=$r6, var3463=$r8, var1470=$r9, var3571=$r10}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration=var299, r1=var2566, $r0=var3366, $r3=var539, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var2829, $r2=var2775, java.lang.Object=var2291, $r4=var2945, $r7=var1625, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta=var3712, $r5=var377, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta=var3569, $r6=var3247, $r8=var3463, $r9=var1470, $r10=var3571}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Registration{mapping=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping mapping>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method=");	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Registration: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta meta>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta getMethod()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1