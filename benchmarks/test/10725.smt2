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

(declare-sort var3384 0)
(declare-sort var3962 0)
(declare-sort var2673 0)
(declare-sort var2238 0)
(declare-sort var2325 0)
(declare-sort var3743 0)
(declare-sort var297 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getApplicationConfigManager/1850072349 (var3384) var3962)
(declare-fun var2673_ofNullable/-1077078438 (var2238) var2673)
(declare-fun cast-from-var3962-to-var2238 (var3962) var2238)
(declare-fun var2325_getApplicationConfig/-1234892824 (var3384) var2673)
(declare-fun isPresent/580259846 (var2673) Bool)
(declare-fun get/-61389134 (var2673) var2238)
(declare-fun cast-from-var2238-to-var3743 (var2238) var3743)
(declare-fun getMetadataServiceProtocol/-455415632 (var3743) String)
(declare-const null-var3384 var3384)
(declare-const null-String String)
(declare-const var995 var3384) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var995 null-var3384)))
(assert true)
(define-const var2355 var3962 (getApplicationConfigManager/1850072349 var995)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>() 
(define-const var2405 var2673 (var2673_ofNullable/-1077078438 (cast-from-var3962-to-var2238 var2355))) ; Statement: r2 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>($r1) 
(define-const var1930 var2673 (var2325_getApplicationConfig/-1234892824 var995)) ; Statement: r3 = staticinvoke <org.apache.dubbo.metadata.util.MetadataServiceVersionUtils: java.util.Optional getApplicationConfig(org.apache.dubbo.rpc.model.ApplicationModel)>(r0) 
(assert true)
(define-const var2653 Bool (isPresent/580259846 var1930)) ; Statement: $z0 = virtualinvoke r3.<java.util.Optional: boolean isPresent()>() 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r2.<java.util.Optional: boolean isPresent()>() 
(assert (not (= (ite var2653 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2259 var2238 (get/-61389134 var1930)) ; Statement: $r15 = virtualinvoke r3.<java.util.Optional: java.lang.Object get()>() 
(define-const var3017 var3743 (cast-from-var2238-to-var3743 var2259)) ; Statement: $r16 = (org.apache.dubbo.config.ApplicationConfig) $r15 
(assert true)
(define-const var2806 String (getMetadataServiceProtocol/-455415632 var3017)) ; Statement: $r17 = virtualinvoke $r16.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataServiceProtocol()>() 
 ; Statement: if $r17 == null goto $z1 = virtualinvoke r2.<java.util.Optional: boolean isPresent()>() 
(assert (not (= var2806 null-String))) ; Negate: Cond: $r17 == null  
(define-const var1042 String "tri") ; Statement: $r21 = "tri" 
(assert true)
(define-const var2783 var2238 (get/-61389134 var1930)) ; Statement: $r18 = virtualinvoke r3.<java.util.Optional: java.lang.Object get()>() 
(define-const var717 var3743 (cast-from-var2238-to-var3743 var2783)) ; Statement: $r19 = (org.apache.dubbo.config.ApplicationConfig) $r18 
(assert true)
(define-const var3750 String (getMetadataServiceProtocol/-455415632 var717)) ; Statement: $r20 = virtualinvoke $r19.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataServiceProtocol()>() 
(assert true)
(define-const var447 Bool (= var1042 var3750)) ; Statement: $z5 = virtualinvoke $r21.<java.lang.String: boolean equals(java.lang.Object)>($r20) 
 ; Statement: return $z5 
(check-sat)
; {getApplicationConfigManager/1850072349=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.context.ConfigManager), var2673_ofNullable/-1077078438=([java.lang.Object], java.util.Optional), cast-from-var3962-to-var2238=([org.apache.dubbo.config.context.ConfigManager], java.lang.Object), var2325_getApplicationConfig/-1234892824=([org.apache.dubbo.rpc.model.ApplicationModel], java.util.Optional), isPresent/580259846=([java.util.Optional], boolean), get/-61389134=([java.util.Optional], java.lang.Object), cast-from-var2238-to-var3743=([java.lang.Object], org.apache.dubbo.config.ApplicationConfig), getMetadataServiceProtocol/-455415632=([org.apache.dubbo.config.ApplicationConfig], java.lang.String)}
; {var3384=org.apache.dubbo.rpc.model.ApplicationModel, var995=r0, var3962=org.apache.dubbo.config.context.ConfigManager, var2355=$r1, var2673=java.util.Optional, var2238=java.lang.Object, var2405=r2, var2325=org.apache.dubbo.metadata.util.MetadataServiceVersionUtils, var1930=r3, var2653=$z0, var2259=$r15, var3743=org.apache.dubbo.config.ApplicationConfig, var3017=$r16, var2806=$r17, var297=null_type, var1042=$r21, var2783=$r18, var717=$r19, var3750=$r20, var447=$z5}
; {org.apache.dubbo.rpc.model.ApplicationModel=var3384, r0=var995, org.apache.dubbo.config.context.ConfigManager=var3962, $r1=var2355, java.util.Optional=var2673, java.lang.Object=var2238, r2=var2405, org.apache.dubbo.metadata.util.MetadataServiceVersionUtils=var2325, r3=var1930, $z0=var2653, $r15=var2259, org.apache.dubbo.config.ApplicationConfig=var3743, $r16=var3017, $r17=var2806, null_type=var297, $r21=var1042, $r18=var2783, $r19=var717, $r20=var3750, $z5=var447}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>();	r2 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>($r1);	r3 = staticinvoke <org.apache.dubbo.metadata.util.MetadataServiceVersionUtils: java.util.Optional getApplicationConfig(org.apache.dubbo.rpc.model.ApplicationModel)>(r0);	$z0 = virtualinvoke r3.<java.util.Optional: boolean isPresent()>();	if $z0 == 0 goto $z1 = virtualinvoke r2.<java.util.Optional: boolean isPresent()>();	$r15 = virtualinvoke r3.<java.util.Optional: java.lang.Object get()>();	$r16 = (org.apache.dubbo.config.ApplicationConfig) $r15;	$r17 = virtualinvoke $r16.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataServiceProtocol()>();	if $r17 == null goto $z1 = virtualinvoke r2.<java.util.Optional: boolean isPresent()>();	$r21 = "tri";	$r18 = virtualinvoke r3.<java.util.Optional: java.lang.Object get()>();	$r19 = (org.apache.dubbo.config.ApplicationConfig) $r18;	$r20 = virtualinvoke $r19.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataServiceProtocol()>();	$z5 = virtualinvoke $r21.<java.lang.String: boolean equals(java.lang.Object)>($r20);	return $z5
;block_num 3