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

(declare-sort var879 0)
(declare-sort var2410 0)
(declare-sort var2736 0)
(declare-sort var651 0)
(declare-sort var1865 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getApplicationConfigManager/1850072349 (var2410) var2736)
(declare-fun getApplicationOrElseThrow/-1966155983 (var2736) var651)
(declare-fun getMetadataType/-1382817533 (var651) String)
(declare-fun var1865_isEmpty/-813097145 (String) Bool)
(declare-const null-var879 var879)
(declare-const null-var2410 var2410)
(declare-const var1466 var879) ; Statement: r3 := @this: org.apache.dubbo.config.metadata.ExporterDeployListener 
(assert (not (= var1466 null-var879)))
(declare-const var3940 var2410) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var3940 null-var2410)))
(assert true)
(define-const var1450 var2736 (getApplicationConfigManager/1850072349 var3940)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>() 
(assert true)
(define-const var2313 var651 (getApplicationOrElseThrow/-1966155983 var1450)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.config.context.ConfigManager: org.apache.dubbo.config.ApplicationConfig getApplicationOrElseThrow()>() 
(assert true)
(define-const var3999 String (getMetadataType/-1382817533 var2313)) ; Statement: r4 = virtualinvoke $r2.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataType()>() 
(define-const var3008 Bool (var1865_isEmpty/-813097145 var3999)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto return r4 
(assert (= (ite var3008 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r4 
(check-sat)
; {getApplicationConfigManager/1850072349=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.context.ConfigManager), getApplicationOrElseThrow/-1966155983=([org.apache.dubbo.config.context.ConfigManager], org.apache.dubbo.config.ApplicationConfig), getMetadataType/-1382817533=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), var1865_isEmpty/-813097145=([java.lang.String], boolean)}
; {var879=org.apache.dubbo.config.metadata.ExporterDeployListener, var1466=r3, var2410=org.apache.dubbo.rpc.model.ApplicationModel, var3940=r0, var2736=org.apache.dubbo.config.context.ConfigManager, var1450=$r1, var651=org.apache.dubbo.config.ApplicationConfig, var2313=$r2, var3999=r4, var1865=org.apache.dubbo.common.utils.StringUtils, var3008=$z0}
; {org.apache.dubbo.config.metadata.ExporterDeployListener=var879, r3=var1466, org.apache.dubbo.rpc.model.ApplicationModel=var2410, r0=var3940, org.apache.dubbo.config.context.ConfigManager=var2736, $r1=var1450, org.apache.dubbo.config.ApplicationConfig=var651, $r2=var2313, r4=var3999, org.apache.dubbo.common.utils.StringUtils=var1865, $z0=var3008}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.metadata.ExporterDeployListener;	r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.config.context.ConfigManager: org.apache.dubbo.config.ApplicationConfig getApplicationOrElseThrow()>();	r4 = virtualinvoke $r2.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataType()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto return r4;	return r4
;block_num 2