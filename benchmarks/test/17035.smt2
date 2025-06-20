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

(declare-sort var2528 0)
(declare-sort var874 0)
(declare-sort var633 0)
(declare-sort var2403 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var874_getSystemProperty/1393069448 (String) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var633_isNotEmpty/-1251449450 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun getParameter/448702405 (var2528 String Int) Int)
(declare-const null-var2528 var2528)
(declare-const null-var2403 var2403)
(declare-const var3793 var2528) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3793 null-var2528)))
(define-const var2631 String (var874_getSystemProperty/1393069448 "dubbo.protocol.default-heartbeat")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-heartbeat") 
(define-const var1710 Int (cast-from-Int-to-Int 60000)) ; Statement: $i3 = (int) 60000 
(define-const var910 Int var1710) ; Statement: i0 = $i3 
(define-const var3617 Bool (var633_isNotEmpty/-1251449450 var2631)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0) 
(assert (not (= (ite var3617 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var910!1 Int (Int_parseInt/1370970945 var2631)) ; Statement: i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r0) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2299 var2403) ; Statement: $r2 := @caughtexception 
(assert (not (= var2299 null-var2403)))
(assert true) ; Non Conditional
(assert true)
(define-const var172 Int (getParameter/448702405 var3793 "heartbeat" var910!1)) ; Statement: $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0) 
 ; Statement: return $i1 
(check-sat)
; {var874_getSystemProperty/1393069448=([java.lang.String], java.lang.String), cast-from-Int-to-Int=([int], int), var633_isNotEmpty/-1251449450=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int)}
; {var2528=org.apache.dubbo.common.URL, var3793=r1, var874=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2631=r0, var1710=$i3, var910=i0, var633=org.apache.dubbo.common.utils.StringUtils, var3617=$z0, var2403=java.lang.NumberFormatException, var2299=$r2, var172=$i1}
; {org.apache.dubbo.common.URL=var2528, r1=var3793, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var874, r0=var2631, $i3=var1710, i0=var910, org.apache.dubbo.common.utils.StringUtils=var633, $z0=var3617, java.lang.NumberFormatException=var2403, $r2=var2299, $i1=var172}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.URL;	r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-heartbeat");	$i3 = (int) 60000;	i0 = $i3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0);	i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r0);	$r2 := @caughtexception;	$i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("heartbeat", i0);	return $i1
;block_num 4