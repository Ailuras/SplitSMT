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

(declare-sort var2687 0)
(declare-sort var2380 0)
(declare-sort var1649 0)
(declare-sort var3896 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2380_getSystemProperty/1393069448 (String) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1649_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getParameter/448702405 (var2687 String Int) Int)
(declare-fun var3896_getHeartbeat/-289072484 (var2687) Int)
(declare-const null-var2687 var2687)
(declare-const var1604 var2687) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1604 null-var2687)))
(define-const var599 String (var2380_getSystemProperty/1393069448 "dubbo.protocol.default-close-timeout")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-close-timeout") 
(define-const var2310 Int (cast-from-Int-to-Int -1)) ; Statement: $i5 = (int) -1 
(define-const var3352 Int var2310) ; Statement: i3 = $i5 
(define-const var3413 Bool (var1649_isNotEmpty/-1251449450 var599)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3413 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if i3 >= 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("close.timeout", i3) 
(assert (>= var3352 0)) ; Cond: i3 >= 0 
(assert true)
(define-const var1344 Int (getParameter/448702405 var1604 "close.timeout" var3352)) ; Statement: $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("close.timeout", i3) 
(define-const var3234 Int (var3896_getHeartbeat/-289072484 var1604)) ; Statement: $i2 = staticinvoke <org.apache.dubbo.remoting.utils.UrlUtils: int getHeartbeat(org.apache.dubbo.common.URL)>(r1) 
(define-const var553 Int (* var3234 2)) ; Statement: $i0 = $i2 * 2 
 ; Statement: if $i1 >= $i0 goto return $i1 
(assert (>= var1344 var553)) ; Cond: $i1 >= $i0 
 ; Statement: return $i1 
(check-sat)
; {var2380_getSystemProperty/1393069448=([java.lang.String], java.lang.String), cast-from-Int-to-Int=([int], int), var1649_isNotEmpty/-1251449450=([java.lang.String], boolean), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), var3896_getHeartbeat/-289072484=([org.apache.dubbo.common.URL], int)}
; {var2687=org.apache.dubbo.common.URL, var1604=r1, var2380=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var599=r0, var2310=$i5, var3352=i3, var1649=org.apache.dubbo.common.utils.StringUtils, var3413=$z0, var1344=$i1, var3896=org.apache.dubbo.remoting.utils.UrlUtils, var3234=$i2, var553=$i0}
; {org.apache.dubbo.common.URL=var2687, r1=var1604, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2380, r0=var599, $i5=var2310, i3=var3352, org.apache.dubbo.common.utils.StringUtils=var1649, $z0=var3413, $i1=var1344, org.apache.dubbo.remoting.utils.UrlUtils=var3896, $i2=var3234, $i0=var553}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.URL;	r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-close-timeout");	$i5 = (int) -1;	i3 = $i5;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto (branch);	if i3 >= 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("close.timeout", i3);	$i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("close.timeout", i3);	$i2 = staticinvoke <org.apache.dubbo.remoting.utils.UrlUtils: int getHeartbeat(org.apache.dubbo.common.URL)>(r1);	$i0 = $i2 * 2;	if $i1 >= $i0 goto return $i1;	return $i1
;block_num 4