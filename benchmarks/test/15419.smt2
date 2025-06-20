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

(declare-sort var1678 0)
(declare-sort var678 0)
(declare-sort var2224 0)
(declare-sort var1711 0)
(declare-sort var1174 0)
(declare-sort var3420 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var1678 String) Bool)
(declare-fun getServiceInfo/1819121692 (var1678 String) var2224)
(declare-fun var1711_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getParameters/557264883 (var1678) var1174)
(declare-fun var1174_keySet/-712633290 (var1174) var3420)
(declare-fun var3420_iterator/1911472585 (var3420) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var1678 var1678)
(declare-const null-String String)
(declare-const var544 var1678) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var544 null-var1678)))
(declare-const var283 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var283 null-String)))
(declare-const var354 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var354 null-String)))
(declare-const var1383 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var1383 null-String)))
(assert true)
(define-const var3561 Bool (consumerParamFirst/5744255 var544 var1383)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2) 
(assert (= (ite var3561 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2904 var2224 (getServiceInfo/1819121692 var544 var283)) ; Statement: $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2) 
(define-const var152 Bool (var1711_isEmpty/-813097145 var354)) ; Statement: $z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z8 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
(assert (not (= (ite var152 1 0) 0))) ; Negate: Cond: $z8 == 0  
(define-const var3285 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3285)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3285!1 String)
(assert (= var3285!1 ""))
(assert true)
(define-const var1468 String (append/672562846 var3285!1 ".")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3285!2 String)
(assert (= var3285!2 (str.++ var3285!1 ".")))
(assert true)
(define-const var271 String (append/672562846 var1468 var1383)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1468!1 String)
(assert (= var1468!1 (str.++ var1468 var1383)))
(assert true)
(define-const var2072 String (toString/-2075883882 var271)) ; Statement: r19 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var3928 var1174 (getParameters/557264883 var544)) ; Statement: $r13 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getParameters()>() 
(define-const var14 var3420 (var1174_keySet/-712633290 var3928)) ; Statement: $r14 = interfaceinvoke $r13.<java.util.Map: java.util.Set keySet()>() 
(define-const var3509 Iterator (var3420_iterator/1911472585 var14)) ; Statement: r20 = interfaceinvoke $r14.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3481 Bool (Iterator_hasNext/-1669924200 var3509)) ; Statement: $z5 = interfaceinvoke r20.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z5 == 0 goto return 0 
(assert (= (ite var3481 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: return 0 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), getServiceInfo/1819121692=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], org.apache.dubbo.metadata.MetadataInfo$ServiceInfo), var1711_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getParameters/557264883=([org.apache.dubbo.registry.client.InstanceAddressURL], java.util.Map), var1174_keySet/-712633290=([java.util.Map], java.util.Set), var3420_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var1678=org.apache.dubbo.registry.client.InstanceAddressURL, var544=r0, var283=r2, var678=null_type, var354=r3, var1383=r1, var3561=$z0, var2224=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var2904=$r18, var1711=org.apache.dubbo.common.utils.StringUtils, var152=$z8, var3285=$r10, var1468=$r11, var271=$r12, var2072=r19, var1174=java.util.Map, var3928=$r13, var3420=java.util.Set, var14=$r14, var3509=r20, var3481=$z5}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1678, r0=var544, r2=var283, null_type=var678, r3=var354, r1=var1383, $z0=var3561, org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var2224, $r18=var2904, org.apache.dubbo.common.utils.StringUtils=var1711, $z8=var152, $r10=var3285, $r11=var1468, $r12=var271, r19=var2072, java.util.Map=var1174, $r13=var3928, java.util.Set=var3420, $r14=var14, r20=var3509, $z5=var3481}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2);	$r18 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo getServiceInfo(java.lang.String)>(r2);	$z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z8 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	r19 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getParameters()>();	$r14 = interfaceinvoke $r13.<java.util.Map: java.util.Set keySet()>();	r20 = interfaceinvoke $r14.<java.util.Set: java.util.Iterator iterator()>();	$z5 = interfaceinvoke r20.<java.util.Iterator: boolean hasNext()>();	if $z5 == 0 goto return 0;	return 0
;block_num 5