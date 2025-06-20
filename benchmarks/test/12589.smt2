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

(declare-sort var1064 0)
(declare-sort var1224 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1210489333 (var1064 String) String)
(declare-fun var1224_isEmpty/-813097145 (String) Bool)
(declare-const null-var1064 var1064)
(declare-const var1371 var1064) ; Statement: r0 := @parameter0: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo 
(assert (not (= var1371 null-var1064)))
(assert true)
(define-const var2395 String (getParameter/-1210489333 var1371 "isExtra")) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getParameter(java.lang.String)>("isExtra") 
(define-const var654 Bool (var1224_isEmpty/-813097145 var2395)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {getParameter/-1210489333=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, java.lang.String], java.lang.String), var1224_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1064=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var1371=r0, var2395=$r1, var1224=org.apache.dubbo.common.utils.StringUtils, var654=$z0}
; {org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var1064, r0=var1371, $r1=var2395, org.apache.dubbo.common.utils.StringUtils=var1224, $z0=var654}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo;	$r1 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getParameter(java.lang.String)>("isExtra");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	return $z0
;block_num 1