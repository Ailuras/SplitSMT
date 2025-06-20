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

(declare-sort var556 0)
(declare-sort var3885 0)
(declare-sort var3328 0)
(declare-sort var3662 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3885_isEmpty/-813097145 (String) Bool)
(declare-fun applicationModel/1679408145 (var556) var3328)
(declare-fun getPubModuleModels/-1009319435 (var3328) var3662)
(declare-fun var3885_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var556 var556)
(declare-const var62 var556) ; Statement: r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder 
(assert (not (= var62 null-var556)))
(define-const var2592 String "") ; Statement: r51 = "" 
(define-const var3271 Bool (var3885_isEmpty/-813097145 "")) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>("") 
 ; Statement: if $z0 == 0 goto $r53 = r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (= (ite var3271 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3432 var3328 (applicationModel/1679408145 var62)) ; Statement: $r53 = r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var3710 var3662 (getPubModuleModels/-1009319435 var3432)) ; Statement: $r54 = virtualinvoke $r53.<org.apache.dubbo.rpc.model.ApplicationModel: java.util.List getPubModuleModels()>() 
(define-const var433 Bool (var3885_isEmpty/-813097145 var2592)) ; Statement: $z7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51) 
 ; Statement: if $z7 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51) 
(assert (= (ite var433 1 0) 0)) ; Cond: $z7 == 0 
(define-const var1286 Bool (var3885_isEmpty/-813097145 var2592)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51) 
 ; Statement: if $z1 == 0 goto $z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51) 
(assert (= (ite var1286 1 0) 0)) ; Cond: $z1 == 0 
(define-const var241 Bool (var3885_isEmpty/-813097145 var2592)) ; Statement: $z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51) 
 ; Statement: if $z8 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r51) 
(assert (= (ite var241 1 0) 0)) ; Cond: $z8 == 0 
(define-const var463 Bool (var3885_isNotEmpty/-1251449450 var2592)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r51) 
 ; Statement: if $z2 == 0 goto $r57 = "dubbo" 
(assert (= (ite var463 1 0) 0)) ; Cond: $z2 == 0 
(define-const var11 String "dubbo") ; Statement: $r57 = "dubbo" 
(assert true) ; Non Conditional
 ; Statement: return $r57 
(check-sat)
; {var3885_isEmpty/-813097145=([java.lang.String], boolean), applicationModel/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.rpc.model.ApplicationModel), getPubModuleModels/-1009319435=([org.apache.dubbo.rpc.model.ApplicationModel], java.util.List), var3885_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var556=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder, var62=r0, var2592=r51, var3885=org.apache.dubbo.common.utils.StringUtils, var3271=$z0, var3328=org.apache.dubbo.rpc.model.ApplicationModel, var3432=$r53, var3662=java.util.List, var3710=$r54, var433=$z7, var1286=$z1, var241=$z8, var463=$z2, var11=$r57}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder=var556, r0=var62, r51=var2592, org.apache.dubbo.common.utils.StringUtils=var3885, $z0=var3271, org.apache.dubbo.rpc.model.ApplicationModel=var3328, $r53=var3432, java.util.List=var3662, $r54=var3710, $z7=var433, $z1=var1286, $z8=var241, $z2=var463, $r57=var11}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder;	r51 = "";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>("");	if $z0 == 0 goto $r53 = r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r53 = r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r54 = virtualinvoke $r53.<org.apache.dubbo.rpc.model.ApplicationModel: java.util.List getPubModuleModels()>();	$z7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51);	if $z7 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51);	if $z1 == 0 goto $z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51);	$z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r51);	if $z8 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r51);	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r51);	if $z2 == 0 goto $r57 = "dubbo";	$r57 = "dubbo";	return $r57
;block_num 7