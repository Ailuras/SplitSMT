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

(declare-sort var1080 0)
(declare-sort var3901 0)
(declare-sort var526 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/506106603 (var3901 String String) String)
(declare-fun var526_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1080 var1080)
(declare-const null-var3901 var3901)
(declare-const var1759 var1080) ; Statement: r4 := @this: org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration 
(assert (not (= var1759 null-var1080)))
(declare-const var1229 var3901) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1229 null-var3901)))
(assert true)
(define-const var2340 String (getParameter/506106603 var1229 "dubbo.config-center.base-path" "/config")) ; Statement: r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("dubbo.config-center.base-path", "/config") 
(define-const var1553 Bool (var526_isNotEmpty/-1251449450 var2340)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto return r5 
(assert (= (ite var1553 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r5 
(check-sat)
; {getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var526_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1080=org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration, var1759=r4, var3901=org.apache.dubbo.common.URL, var1229=r0, var2340=r5, var526=org.apache.dubbo.common.utils.StringUtils, var1553=$z0}
; {org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration=var1080, r4=var1759, org.apache.dubbo.common.URL=var3901, r0=var1229, r5=var2340, org.apache.dubbo.common.utils.StringUtils=var526, $z0=var1553}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration;	r0 := @parameter0: org.apache.dubbo.common.URL;	r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("dubbo.config-center.base-path", "/config");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z0 == 0 goto return r5;	return r5
;block_num 2