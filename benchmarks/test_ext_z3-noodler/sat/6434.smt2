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

(declare-sort var2974 0)
(declare-sort var2574 0)
(declare-sort var3309 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2574_interfaceFromServiceKey/131280368 (String) String)
(declare-fun var2574_versionFromServiceKey/1753360625 (String) String)
(declare-fun var3309_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2689 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2689 null-String)))
(define-const var1323 String (var2574_interfaceFromServiceKey/131280368 var2689)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String interfaceFromServiceKey(java.lang.String)>(r0) 
(define-const var821 String (var2574_versionFromServiceKey/1753360625 var2689)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String versionFromServiceKey(java.lang.String)>(r0) 
(define-const var3005 Bool (var3309_isEmpty/-813097145 var821)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.StringBuilder 
(assert (not (= (ite var3005 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var2574_interfaceFromServiceKey/131280368=([java.lang.String], java.lang.String), var2574_versionFromServiceKey/1753360625=([java.lang.String], java.lang.String), var3309_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2689=r0, var2974=null_type, var2574=org.apache.dubbo.common.BaseServiceMetadata, var1323=r1, var821=r2, var3309=org.apache.dubbo.common.utils.StringUtils, var3005=$z0}
; {r0=var2689, null_type=var2974, org.apache.dubbo.common.BaseServiceMetadata=var2574, r1=var1323, r2=var821, org.apache.dubbo.common.utils.StringUtils=var3309, $z0=var3005}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String interfaceFromServiceKey(java.lang.String)>(r0);	r2 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String versionFromServiceKey(java.lang.String)>(r0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = new java.lang.StringBuilder;	return r1
;block_num 2