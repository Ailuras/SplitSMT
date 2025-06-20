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

(declare-sort var2305 0)
(declare-sort var609 0)
(declare-sort var1053 0)
(declare-sort var2996 0)
(declare-sort var3503 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getApplicationConfigManager/1850072349 (var609) var1053)
(declare-fun getApplicationOrElseThrow/-1966155983 (var1053) var2996)
(declare-fun getRegisterMode/478737414 (var2996) String)
(declare-fun var3503_isEmpty/-813097145 (String) Bool)
(declare-const null-var2305 var2305)
(declare-const null-var609 var609)
(declare-const var1045 var2305) ; Statement: r3 := @this: org.apache.dubbo.config.metadata.ExporterDeployListener 
(assert (not (= var1045 null-var2305)))
(declare-const var3343 var609) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var3343 null-var609)))
(assert true)
(define-const var2732 var1053 (getApplicationConfigManager/1850072349 var3343)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>() 
(assert true)
(define-const var209 var2996 (getApplicationOrElseThrow/-1966155983 var2732)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.config.context.ConfigManager: org.apache.dubbo.config.ApplicationConfig getApplicationOrElseThrow()>() 
(assert true)
(define-const var1454 String (getRegisterMode/478737414 var209)) ; Statement: r4 = virtualinvoke $r2.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getRegisterMode()>() 
(define-const var3897 Bool (var3503_isEmpty/-813097145 var1454)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto return r4 
(assert (= (ite var3897 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r4 
(check-sat)
; {getApplicationConfigManager/1850072349=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.context.ConfigManager), getApplicationOrElseThrow/-1966155983=([org.apache.dubbo.config.context.ConfigManager], org.apache.dubbo.config.ApplicationConfig), getRegisterMode/478737414=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), var3503_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2305=org.apache.dubbo.config.metadata.ExporterDeployListener, var1045=r3, var609=org.apache.dubbo.rpc.model.ApplicationModel, var3343=r0, var1053=org.apache.dubbo.config.context.ConfigManager, var2732=$r1, var2996=org.apache.dubbo.config.ApplicationConfig, var209=$r2, var1454=r4, var3503=org.apache.dubbo.common.utils.StringUtils, var3897=$z0}
; {org.apache.dubbo.config.metadata.ExporterDeployListener=var2305, r3=var1045, org.apache.dubbo.rpc.model.ApplicationModel=var609, r0=var3343, org.apache.dubbo.config.context.ConfigManager=var1053, $r1=var2732, org.apache.dubbo.config.ApplicationConfig=var2996, $r2=var209, r4=var1454, org.apache.dubbo.common.utils.StringUtils=var3503, $z0=var3897}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.metadata.ExporterDeployListener;	r0 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.config.context.ConfigManager: org.apache.dubbo.config.ApplicationConfig getApplicationOrElseThrow()>();	r4 = virtualinvoke $r2.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getRegisterMode()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto return r4;	return r4
;block_num 2