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

(declare-sort var3353 0)
(declare-sort var747 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3353 String) String)
(declare-fun var747_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3353 var3353)
(declare-const var1462 var3353) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1462 null-var3353)))
(assert true)
(define-const var694 String (getParameter/-1307325648 var1462 "registry-protocol-type")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("registry-protocol-type") 
(define-const var3150 Bool (var747_isNotEmpty/-1251449450 var694)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = "registry" 
(assert (not (= (ite var3150 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var615 String var694) ; Statement: $r2 = r1 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var747_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3353=org.apache.dubbo.common.URL, var1462=r0, var694=r1, var747=org.apache.dubbo.common.utils.StringUtils, var3150=$z0, var615=$r2}
; {org.apache.dubbo.common.URL=var3353, r0=var1462, r1=var694, org.apache.dubbo.common.utils.StringUtils=var747, $z0=var3150, $r2=var615}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("registry-protocol-type");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = "registry";	$r2 = r1;	goto [?= return $r2];	return $r2
;block_num 3