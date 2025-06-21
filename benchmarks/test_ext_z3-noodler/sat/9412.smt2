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

(declare-sort var1944 0)
(declare-sort var1440 0)
(declare-sort var565 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBackupAddress/-787387966 (var1440) String)
(declare-fun var565_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1944 var1944)
(declare-const null-var1440 var1440)
(declare-const var1549 var1944) ; Statement: r8 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration 
(assert (not (= var1549 null-var1944)))
(declare-const var2477 var1440) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2477 null-var1440)))
(assert true)
(define-const var2720 String (getBackupAddress/-787387966 var2477)) ; Statement: r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getBackupAddress()>() 
(define-const var626 Bool (var565_isNotEmpty/-1251449450 var2720)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r9) 
 ; Statement: if $z0 == 0 goto return r9 
(assert (= (ite var626 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r9 
(check-sat)
; {getBackupAddress/-787387966=([org.apache.dubbo.common.URL], java.lang.String), var565_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1944=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, var1549=r8, var1440=org.apache.dubbo.common.URL, var2477=r0, var2720=r9, var565=org.apache.dubbo.common.utils.StringUtils, var626=$z0}
; {org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration=var1944, r8=var1549, org.apache.dubbo.common.URL=var1440, r0=var2477, r9=var2720, org.apache.dubbo.common.utils.StringUtils=var565, $z0=var626}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r8 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration;	r0 := @parameter0: org.apache.dubbo.common.URL;	r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getBackupAddress()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r9);	if $z0 == 0 goto return r9;	return r9
;block_num 2