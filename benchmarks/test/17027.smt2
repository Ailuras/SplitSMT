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

(declare-sort var3801 0)
(declare-sort var1511 0)
(declare-sort var2217 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1511_getSystemProperty/1393069448 (String) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var2217_isNotEmpty/-1251449450 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun getParameter/448702405 (var3801 String Int) Int)
(declare-const null-var3801 var3801)
(declare-const var1326 var3801) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1326 null-var3801)))
(define-const var2816 String (var1511_getSystemProperty/1393069448 "dubbo.protocol.default-heartbeat")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-heartbeat") 
(define-const var952 Int (cast-from-Int-to-Int 60000)) ; Statement: $i3 = (int) 60000 
(define-const var1825 Int var952) ; Statement: i0 = $i3 
(define-const var1470 Bool (var2217_isNotEmpty/-1251449450 var2816)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0) 
(assert (not (= (ite var1470 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1825!1 Int (Int_parseInt/1370970945 var2816)) ; Statement: i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r0) 
(assert true) ; Non Conditional
 ; Statement: goto [?= $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0)] 
(assert true) ; Non Conditional
(assert true)
(define-const var150 Int (getParameter/448702405 var1326 "heartbeat" var1825!1)) ; Statement: $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0) 
 ; Statement: return $i1 
(check-sat)
; {var1511_getSystemProperty/1393069448=([java.lang.String], java.lang.String), cast-from-Int-to-Int=([int], int), var2217_isNotEmpty/-1251449450=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int)}
; {var3801=org.apache.dubbo.common.URL, var1326=r1, var1511=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2816=r0, var952=$i3, var1825=i0, var2217=org.apache.dubbo.common.utils.StringUtils, var1470=$z0, var150=$i1}
; {org.apache.dubbo.common.URL=var3801, r1=var1326, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var1511, r0=var2816, $i3=var952, i0=var1825, org.apache.dubbo.common.utils.StringUtils=var2217, $z0=var1470, $i1=var150}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.URL;	r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-heartbeat");	$i3 = (int) 60000;	i0 = $i3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0);	i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r0);	goto [?= $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0)];	$i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0);	return $i1
;block_num 4