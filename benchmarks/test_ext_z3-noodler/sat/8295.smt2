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

(declare-sort var834 0)
(declare-sort var1279 0)
(declare-sort var2506 0)
(declare-sort var3133 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2506_isEmpty/-813097145 (String) Bool)
(declare-fun var2506_parseQueryString/-1071871736 (String) var3133)
(declare-fun addParameters/1869535242 (var834 var3133) var834)
(declare-const null-var834 var834)
(declare-const null-String String)
(declare-const var1503 var834) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1503 null-var834)))
(declare-const var675 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var675 null-String)))
(define-const var3014 Bool (var2506_isEmpty/-813097145 var675)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0) 
(assert (= (ite var3014 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2468 var3133 (var2506_parseQueryString/-1071871736 var675)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0) 
(assert true)
(define-const var775 var834 (addParameters/1869535242 var1503 var2468)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.util.Map)>($r2) 
 ; Statement: return $r3 
(check-sat)
; {var2506_isEmpty/-813097145=([java.lang.String], boolean), var2506_parseQueryString/-1071871736=([java.lang.String], java.util.Map), addParameters/1869535242=([org.apache.dubbo.common.URL, java.util.Map], org.apache.dubbo.common.URL)}
; {var834=org.apache.dubbo.common.URL, var1503=r1, var675=r0, var1279=null_type, var2506=org.apache.dubbo.common.utils.StringUtils, var3014=$z0, var3133=java.util.Map, var2468=$r2, var775=$r3}
; {org.apache.dubbo.common.URL=var834, r1=var1503, r0=var675, null_type=var1279, org.apache.dubbo.common.utils.StringUtils=var2506, $z0=var3014, java.util.Map=var3133, $r2=var2468, $r3=var775}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0);	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0);	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.util.Map)>($r2);	return $r3
;block_num 2