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

(declare-sort var3925 0)
(declare-sort var3035 0)
(declare-sort var964 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3035_interfaceFromServiceKey/131280368 (String) String)
(declare-fun var3035_versionFromServiceKey/1753360625 (String) String)
(declare-fun var964_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var600 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var600 null-String)))
(define-const var3710 String (var3035_interfaceFromServiceKey/131280368 var600)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String interfaceFromServiceKey(java.lang.String)>(r0) 
(define-const var3558 String (var3035_versionFromServiceKey/1753360625 var600)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String versionFromServiceKey(java.lang.String)>(r0) 
(define-const var629 Bool (var964_isEmpty/-813097145 var3558)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.StringBuilder 
(assert (not (= (ite var629 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var3035_interfaceFromServiceKey/131280368=([java.lang.String], java.lang.String), var3035_versionFromServiceKey/1753360625=([java.lang.String], java.lang.String), var964_isEmpty/-813097145=([java.lang.String], boolean)}
; {var600=r0, var3925=null_type, var3035=org.apache.dubbo.common.BaseServiceMetadata, var3710=r1, var3558=r2, var964=org.apache.dubbo.common.utils.StringUtils, var629=$z0}
; {r0=var600, null_type=var3925, org.apache.dubbo.common.BaseServiceMetadata=var3035, r1=var3710, r2=var3558, org.apache.dubbo.common.utils.StringUtils=var964, $z0=var629}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String interfaceFromServiceKey(java.lang.String)>(r0);	r2 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String versionFromServiceKey(java.lang.String)>(r0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = new java.lang.StringBuilder;	return r1
;block_num 2