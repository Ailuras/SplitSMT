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

(declare-sort var2015 0)
(declare-sort var167 0)
(declare-sort var3605 0)
(declare-sort var1801 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var2015 String) Bool)
(declare-fun metadataInfo/507655048 (var2015) var3605)
(declare-fun getParameter/-1925727985 (var3605 String String) String)
(declare-fun var1801_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getInstanceParameter/1439176475 (var2015 String) String)
(declare-const null-var2015 var2015)
(declare-const null-String String)
(declare-const null-var3605 var3605)
(declare-const var2939 var2015) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var2939 null-var2015)))
(declare-const var587 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var587 null-String)))
(declare-const var1698 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1698 null-String)))
(assert true)
(define-const var2330 Bool (consumerParamFirst/5744255 var2939 var1698)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert (= (ite var2330 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2009 var3605 (metadataInfo/507655048 var2939)) ; Statement: $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
 ; Statement: if $r8 == null goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1) 
(assert (not (= var2009 null-var3605))) ; Negate: Cond: $r8 == null  
(define-const var3822 var3605 (metadataInfo/507655048 var2939)) ; Statement: $r4 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo> 
(assert true)
(define-const var1386 String (getParameter/-1925727985 var3822 var1698 var587)) ; Statement: r9 = virtualinvoke $r4.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getParameter(java.lang.String,java.lang.String)>(r1, r3) 
(define-const var17 Bool (var1801_isNotEmpty/-1251449450 var1386)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r9) 
 ; Statement: if $z1 == 0 goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1) 
(assert (= (ite var17 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var930 String (getInstanceParameter/1439176475 var2939 var1698)) ; Statement: $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1) 
 ; Statement: return $r2 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), metadataInfo/507655048=([org.apache.dubbo.registry.client.InstanceAddressURL], org.apache.dubbo.metadata.MetadataInfo), getParameter/-1925727985=([org.apache.dubbo.metadata.MetadataInfo, java.lang.String, java.lang.String], java.lang.String), var1801_isNotEmpty/-1251449450=([java.lang.String], boolean), getInstanceParameter/1439176475=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], java.lang.String)}
; {var2015=org.apache.dubbo.registry.client.InstanceAddressURL, var2939=r0, var587=r3, var167=null_type, var1698=r1, var2330=$z0, var3605=org.apache.dubbo.metadata.MetadataInfo, var2009=$r8, var3822=$r4, var1386=r9, var1801=org.apache.dubbo.common.utils.StringUtils, var17=$z1, var930=$r2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2015, r0=var2939, r3=var587, null_type=var167, r1=var1698, $z0=var2330, org.apache.dubbo.metadata.MetadataInfo=var3605, $r8=var2009, $r4=var3822, r9=var1386, org.apache.dubbo.common.utils.StringUtils=var1801, $z1=var17, $r2=var930}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	$r8 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	if $r8 == null goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1);	$r4 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.metadata.MetadataInfo metadataInfo>;	r9 = virtualinvoke $r4.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getParameter(java.lang.String,java.lang.String)>(r1, r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r9);	if $z1 == 0 goto $r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1);	$r2 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getInstanceParameter(java.lang.String)>(r1);	return $r2
;block_num 4