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

(declare-sort var2129 0)
(declare-sort var3049 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toShortString/-1134278171 (var2129) String)
(declare-fun serviceMeta/-16768289 (var2129) var3049)
(declare-fun toShortString/-1551919525 (var3049) String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2129 var2129)
(declare-const var202 var2129) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta 
(assert (not (= var202 null-var2129)))
(define-const var3746 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3746)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3746!1 String)
(assert (= var3746!1 ""))
(assert true)
(define-const var59 String (append/672562846 var3746!1 "MethodMeta{method=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodMeta{method=") 
(declare-const var3746!2 String)
(assert (= var3746!2 (str.++ var3746!1 "MethodMeta{method=")))
(assert true)
(define-const var3299 String (toShortString/-1134278171 var202)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: java.lang.String toShortString()>() 
(assert true)
(define-const var409 String (append/672562846 var59 var3299)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var59!1 String)
(assert (= var59!1 (str.++ var59 var3299)))
(assert true)
(define-const var1290 String (append/672562846 var409 ", service=")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", service=") 
(declare-const var409!1 String)
(assert (= var409!1 (str.++ var409 ", service=")))
(define-const var215 var3049 (serviceMeta/-16768289 var202)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta serviceMeta> 
(assert true)
(define-const var3742 String (toShortString/-1551919525 var215)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String toShortString()>() 
(assert true)
(define-const var16 String (append/672562846 var1290 var3742)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1290!1 String)
(assert (= var1290!1 (str.++ var1290 var3742)))
(assert true)
(define-const var879 String (append/-1166366385 var16 125)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var16!1 String)
(assert (str.prefixof var16 var16!1))
(assert true)
(define-const var1616 String (toString/-2075883882 var879)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toShortString/-1134278171=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta], java.lang.String), serviceMeta/-16768289=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta), toShortString/-1551919525=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2129=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta, var202=r1, var3746=$r0, var59=$r3, var3299=$r2, var409=$r4, var1290=$r7, var3049=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta, var215=$r5, var3742=$r6, var16=$r8, var879=$r9, var1616=$r10}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta=var2129, r1=var202, $r0=var3746, $r3=var59, $r2=var3299, $r4=var409, $r7=var1290, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta=var3049, $r5=var215, $r6=var3742, $r8=var16, $r9=var879, $r10=var1616}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodMeta{method=");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: java.lang.String toShortString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", service=");	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta serviceMeta>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String toShortString()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1