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

(declare-sort var825 0)
(declare-sort var3059 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getServiceInterface/755123731 (var825) String)
(declare-fun toShortString/-1551919525 (var825) String)
(declare-fun contextPath/-1504388831 (var825) String)
(declare-fun var3059_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getServiceGroup/-1234071923 (var825) String)
(declare-fun getServiceVersion/1862850004 (var825) String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var825 var825)
(declare-const var664 var825) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta 
(assert (not (= var664 null-var825)))
(define-const var699 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var699 64)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(64) 

(declare-const var699!1 String)
(declare-const var692 Int)
(assert true)
(define-const var188 String (append/672562846 var699!1 "ServiceMeta{interface=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceMeta{interface=") 
(declare-const var699!2 String)
(assert (= var699!2 (str.++ var699!1 "ServiceMeta{interface=")))
(assert true)
(define-const var2894 String (getServiceInterface/755123731 var664)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var908 String (append/672562846 var188 var2894)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var188!1 String)
(assert (= var188!1 (str.++ var188 var2894)))
(assert true)
(define-const var140 String (append/672562846 var908 ", service=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", service=") 
(declare-const var908!1 String)
(assert (= var908!1 (str.++ var908 ", service=")))
(assert true)
(define-const var2086 String (toShortString/-1551919525 var664)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String toShortString()>() 
(assert true)
;(assert (append/672562846 var140 var2086)) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var140!1 String)
(assert (= var140!1 (str.++ var140 var2086)))
(define-const var2088 String (contextPath/-1504388831 var664)) ; Statement: $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String contextPath> 
(define-const var3237 Bool (var3059_isNotEmpty/-1251449450 var2088)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r7) 
 ; Statement: if $z0 == 0 goto $r17 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceGroup()>() 
(assert (= (ite var3237 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1089 String (getServiceGroup/-1234071923 var664)) ; Statement: $r17 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceGroup()>() 
(define-const var1367 Bool (var3059_isNotEmpty/-1251449450 var1089)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r17) 
 ; Statement: if $z1 == 0 goto $r13 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceVersion()>() 
(assert (= (ite var1367 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var504 String (getServiceVersion/1862850004 var664)) ; Statement: $r13 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceVersion()>() 
(define-const var2021 Bool (var3059_isNotEmpty/-1251449450 var504)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r13) 
 ; Statement: if $z2 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= (ite var2021 1 0) 0)) ; Cond: $z2 == 0 
(assert true)
;(assert (append/-1166366385 var699!2 125)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var699!3 String)
(assert (str.prefixof var699!2 var699!3))
(assert true)
(define-const var3142 String (toString/-2075883882 var699!3)) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getServiceInterface/755123731=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta], java.lang.String), toShortString/-1551919525=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta], java.lang.String), contextPath/-1504388831=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta], java.lang.String), var3059_isNotEmpty/-1251449450=([java.lang.String], boolean), getServiceGroup/-1234071923=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta], java.lang.String), getServiceVersion/1862850004=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var825=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta, var664=r1, var699=$r0, var692=64, var188=$r3, var2894=$r2, var908=$r4, var140=$r6, var2086=$r5, var2088=$r7, var3059=org.apache.dubbo.common.utils.StringUtils, var3237=$z0, var1089=$r17, var1367=$z1, var504=$r13, var2021=$z2, var3142=$r8}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta=var825, r1=var664, $r0=var699, 64=var692, $r3=var188, $r2=var2894, $r4=var908, $r6=var140, $r5=var2086, $r7=var2088, org.apache.dubbo.common.utils.StringUtils=var3059, $z0=var3237, $r17=var1089, $z1=var1367, $r13=var504, $z2=var2021, $r8=var3142}
;seq <java.lang.StringBuilder: void <init>(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(64);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceMeta{interface=");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceInterface()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", service=");	$r5 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String toShortString()>();	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String contextPath>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r7);	if $z0 == 0 goto $r17 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceGroup()>();	$r17 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceGroup()>();	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r17);	if $z1 == 0 goto $r13 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceVersion()>();	$r13 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.String getServiceVersion()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r13);	if $z2 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 4