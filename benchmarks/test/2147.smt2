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

(declare-sort var1731 0)
(declare-sort var542 0)
(declare-sort var572 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun buildRootPath/709018557 (var1731 var542) String)
(declare-fun getParameter/506106603 (var542 String String) String)
(declare-fun var572_normalize/1742594772 (String) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var1731 var1731)
(declare-const null-var542 var542)
(declare-const var2928 var1731) ; Statement: r1 := @this: org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration 
(assert (not (= var2928 null-var1731)))
(declare-const var6 var542) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var6 null-var542)))
(assert true)
(define-const var812 String (buildRootPath/709018557 var2928 var6)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration: java.lang.String buildRootPath(org.apache.dubbo.common.URL)>(r0) 
(assert true)
(define-const var98 String (getParameter/506106603 var6 "dubbo.config-center.root-path" var812)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("dubbo.config-center.root-path", $r2) 
(define-const var1442 String (var572_normalize/1742594772 var98)) ; Statement: r4 = staticinvoke <org.apache.dubbo.common.utils.PathUtils: java.lang.String normalize(java.lang.String)>(r3) 
(assert true)
(define-const var1159 Int (length/-134980193 var1442)) ; Statement: i0 = virtualinvoke r4.<java.lang.String: int length()>() 
 ; Statement: if i0 <= 1 goto return r4 
(assert (<= var1159 1)) ; Cond: i0 <= 1 
 ; Statement: return r4 
(check-sat)
; {buildRootPath/709018557=([org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration, org.apache.dubbo.common.URL], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var572_normalize/1742594772=([java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var1731=org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration, var2928=r1, var542=org.apache.dubbo.common.URL, var6=r0, var812=$r2, var98=r3, var572=org.apache.dubbo.common.utils.PathUtils, var1442=r4, var1159=i0}
; {org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration=var1731, r1=var2928, org.apache.dubbo.common.URL=var542, r0=var6, $r2=var812, r3=var98, org.apache.dubbo.common.utils.PathUtils=var572, r4=var1442, i0=var1159}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = specialinvoke r1.<org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration: java.lang.String buildRootPath(org.apache.dubbo.common.URL)>(r0);	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("dubbo.config-center.root-path", $r2);	r4 = staticinvoke <org.apache.dubbo.common.utils.PathUtils: java.lang.String normalize(java.lang.String)>(r3);	i0 = virtualinvoke r4.<java.lang.String: int length()>();	if i0 <= 1 goto return r4;	return r4
;block_num 2