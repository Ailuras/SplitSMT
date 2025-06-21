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

(declare-sort var531 0)
(declare-sort var3541 0)
(declare-sort var3608 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3541_getSystemProperty/1393069448 (String) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var3608_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getParameter/448702405 (var531 String Int) Int)
(declare-const null-var531 var531)
(declare-const var3611 var531) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3611 null-var531)))
(define-const var1989 String (var3541_getSystemProperty/1393069448 "dubbo.protocol.default-heartbeat")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-heartbeat") 
(define-const var3756 Int (cast-from-Int-to-Int 60000)) ; Statement: $i3 = (int) 60000 
(define-const var153 Int var3756) ; Statement: i0 = $i3 
(define-const var976 Bool (var3608_isNotEmpty/-1251449450 var1989)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0) 
(assert (= (ite var976 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3542 Int (getParameter/448702405 var3611 "heartbeat" var153)) ; Statement: $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0) 
 ; Statement: return $i1 
(check-sat)
; {var3541_getSystemProperty/1393069448=([java.lang.String], java.lang.String), cast-from-Int-to-Int=([int], int), var3608_isNotEmpty/-1251449450=([java.lang.String], boolean), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int)}
; {var531=org.apache.dubbo.common.URL, var3611=r1, var3541=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var1989=r0, var3756=$i3, var153=i0, var3608=org.apache.dubbo.common.utils.StringUtils, var976=$z0, var3542=$i1}
; {org.apache.dubbo.common.URL=var531, r1=var3611, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3541, r0=var1989, $i3=var3756, i0=var153, org.apache.dubbo.common.utils.StringUtils=var3608, $z0=var976, $i1=var3542}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.URL;	r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-heartbeat");	$i3 = (int) 60000;	i0 = $i3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0);	$i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0);	return $i1
;block_num 2