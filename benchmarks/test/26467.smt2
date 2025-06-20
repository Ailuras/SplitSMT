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

(declare-sort var2351 0)
(declare-sort var2211 0)
(declare-sort var1228 0)
(declare-sort var3098 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun methodsCondition/-1662532433 (var2351) var1228)
(declare-fun pathCondition/-1662532433 (var2351) var3098)
(declare-fun compareTo/1539539463 (var3098 var3098 var2211) Int)
(declare-const null-var2351 var2351)
(declare-const null-var2211 var2211)
(declare-const null-var1228 var1228)
(declare-const null-var3098 var3098)
(declare-const var2789 var2351) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping 
(assert (not (= var2789 null-var2351)))
(declare-const var1592 var2351) ; Statement: r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping 
(assert (not (= var1592 null-var2351)))
(declare-const var1716 var2211) ; Statement: r11 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var1716 null-var2211)))
(define-const var1960 var1228 (methodsCondition/-1662532433 var2789)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition> 
 ; Statement: if $r1 == null goto $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition> 
(assert (= var1960 null-var1228)) ; Cond: $r1 == null 
(define-const var540 var3098 (pathCondition/-1662532433 var2789)) ; Statement: $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition> 
 ; Statement: if $r34 == null goto $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition paramsCondition> 
(assert (not (= var540 null-var3098))) ; Negate: Cond: $r34 == null  
(define-const var2822 var3098 (pathCondition/-1662532433 var2789)) ; Statement: $r28 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition> 
(define-const var246 var3098 (pathCondition/-1662532433 var1592)) ; Statement: $r27 = r9.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition> 
(assert true)
(define-const var3334 Int (compareTo/1539539463 var2822 var246 var1716)) ; Statement: i4 = virtualinvoke $r28.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition,org.apache.dubbo.remoting.http12.HttpRequest)>($r27, r11) 
 ; Statement: if i4 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition paramsCondition> 
(assert (not (= var3334 0))) ; Negate: Cond: i4 == 0  
 ; Statement: return i4 
(check-sat)
; {methodsCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition), pathCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition), compareTo/1539539463=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition, org.apache.dubbo.remoting.http12.HttpRequest], int)}
; {var2351=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var2789=r0, var1592=r9, var2211=org.apache.dubbo.remoting.http12.HttpRequest, var1716=r11, var1228=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition, var1960=$r1, var3098=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition, var540=$r34, var2822=$r28, var246=$r27, var3334=i4}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var2351, r0=var2789, r9=var1592, org.apache.dubbo.remoting.http12.HttpRequest=var2211, r11=var1716, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition=var1228, $r1=var1960, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition=var3098, $r34=var540, $r28=var2822, $r27=var246, i4=var3334}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping;	r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping;	r11 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition>;	if $r1 == null goto $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition>;	$r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition>;	if $r34 == null goto $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition paramsCondition>;	$r28 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition>;	$r27 = r9.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition>;	i4 = virtualinvoke $r28.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition,org.apache.dubbo.remoting.http12.HttpRequest)>($r27, r11);	if i4 == 0 goto $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition paramsCondition>;	return i4
;block_num 4