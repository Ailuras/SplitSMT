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

(declare-sort var532 0)
(declare-sort var616 0)
(declare-sort var2882 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var616 String) String)
(declare-fun var2882_isEmpty/-813097145 (String) Bool)
(declare-const null-var532 var532)
(declare-const null-var616 var616)
(declare-const var347 var532) ; Statement: r2 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var347 null-var532)))
(declare-const var900 var616) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var900 null-var616)))
(assert true)
(define-const var3669 String (getParameter/-1307325648 var900 "compatible_config")) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("compatible_config") 
(define-const var386 Bool (var2882_isEmpty/-813097145 var3669)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2882_isEmpty/-813097145=([java.lang.String], boolean)}
; {var532=org.apache.dubbo.registry.integration.RegistryDirectory, var347=r2, var616=org.apache.dubbo.common.URL, var900=r0, var3669=$r1, var2882=org.apache.dubbo.common.utils.StringUtils, var386=$z0}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var532, r2=var347, org.apache.dubbo.common.URL=var616, r0=var900, $r1=var3669, org.apache.dubbo.common.utils.StringUtils=var2882, $z0=var386}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("compatible_config");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	return $z0
;block_num 1