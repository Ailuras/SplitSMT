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

(declare-sort var1584 0)
(declare-sort var3355 0)
(declare-sort var1618 0)
(declare-sort var3052 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3355_getSystemProperty/1393069448 (String) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1618_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getParameter/448702405 (var1584 String Int) Int)
(declare-const null-var1584 var1584)
(declare-const null-var3052 var3052)
(declare-const var1 var1584) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1 null-var1584)))
(define-const var3536 String (var3355_getSystemProperty/1393069448 "dubbo.protocol.default-heartbeat")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-heartbeat") 
(define-const var3442 Int (cast-from-Int-to-Int 60000)) ; Statement: $i3 = (int) 60000 
(define-const var2425 Int var3442) ; Statement: i0 = $i3 
(define-const var3991 Bool (var1618_isNotEmpty/-1251449450 var3536)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0) 
(assert (not (= (ite var3991 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var3469 var3052) ; Statement: $r2 := @caughtexception 
(assert (not (= var3469 null-var3052)))
(assert true) ; Non Conditional
(assert true)
(define-const var1049 Int (getParameter/448702405 var1 "heartbeat" var2425)) ; Statement: $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0) 
 ; Statement: return $i1 
(check-sat)
; {var3355_getSystemProperty/1393069448=([java.lang.String], java.lang.String), cast-from-Int-to-Int=([int], int), var1618_isNotEmpty/-1251449450=([java.lang.String], boolean), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int)}
; {var1584=org.apache.dubbo.common.URL, var1=r1, var3355=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3536=r0, var3442=$i3, var2425=i0, var1618=org.apache.dubbo.common.utils.StringUtils, var3991=$z0, var3052=java.lang.NumberFormatException, var3469=$r2, var1049=$i1}
; {org.apache.dubbo.common.URL=var1584, r1=var1, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3355, r0=var3536, $i3=var3442, i0=var2425, org.apache.dubbo.common.utils.StringUtils=var1618, $z0=var3991, java.lang.NumberFormatException=var3052, $r2=var3469, $i1=var1049}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.URL;	r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-heartbeat");	$i3 = (int) 60000;	i0 = $i3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0);	$r2 := @caughtexception;	$i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0);	return $i1
;block_num 3