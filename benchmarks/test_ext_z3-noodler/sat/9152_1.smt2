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

(declare-sort var152 0)
(declare-sort var1655 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var152_interfaceName/1282863764 (var152) String)
(declare-fun var1655_hasText/2115555376 (String) Bool)
(declare-const null-var152 var152)
(declare-const null-ClassObject ClassObject)
(declare-const var2806 var152) ; Statement: r0 := @parameter0: org.apache.dubbo.config.annotation.Service 
(assert (not (= var2806 null-var152)))
(declare-const var43 ClassObject) ; Statement: r4 := @parameter1: java.lang.Class 
(assert (not (= var43 null-ClassObject)))
(define-const var3261 String (var152_interfaceName/1282863764 var2806)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.config.'annotation'.Service: java.lang.String interfaceName()>() 
(define-const var12 Bool (var1655_hasText/2115555376 var3261)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = <java.lang.Void: java.lang.Class TYPE> 
(assert (not (= (ite var12 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var460 String (var152_interfaceName/1282863764 var2806)) ; Statement: r13 = interfaceinvoke r0.<org.apache.dubbo.config.'annotation'.Service: java.lang.String interfaceName()>() 
 ; Statement: goto [?= return r13] 
(assert true) ; Non Conditional
 ; Statement: return r13 
(check-sat)
; {var152_interfaceName/1282863764=([org.apache.dubbo.config.annotation.Service], java.lang.String), var1655_hasText/2115555376=([java.lang.String], boolean)}
; {var152=org.apache.dubbo.config.annotation.Service, var2806=r0, var43=r4, var3261=$r1, var1655=org.springframework.util.StringUtils, var12=$z0, var460=r13}
; {org.apache.dubbo.config.annotation.Service=var152, r0=var2806, r4=var43, $r1=var3261, org.springframework.util.StringUtils=var1655, $z0=var12, r13=var460}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.config.annotation.Service;	r4 := @parameter1: java.lang.Class;	$r1 = interfaceinvoke r0.<org.apache.dubbo.config.'annotation'.Service: java.lang.String interfaceName()>();	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = <java.lang.Void: java.lang.Class TYPE>;	r13 = interfaceinvoke r0.<org.apache.dubbo.config.'annotation'.Service: java.lang.String interfaceName()>();	goto [?= return r13];	return r13
;block_num 3