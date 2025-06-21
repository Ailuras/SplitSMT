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

(declare-sort var1037 0)
(declare-sort var2356 0)
(declare-sort var3180 0)
(declare-sort var2490 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3180-init () var3180)
(declare-fun getId/-1251157979 (var1037) Int)
(declare-fun getVersion/440990027 (var1037) String)
(declare-fun <init>/1624423151 (var3180 Int String) void)
(declare-fun setStatus/-969168820 (var3180 Int) void)
(declare-fun var2490_toString/-109309168 (var2356) String)
(declare-fun setErrorMessage/1202863900 (var3180 String) void)
(declare-const null-var1037 var1037)
(declare-const null-var2356 var2356)
(declare-const var123 var1037) ; Statement: r1 := @parameter0: org.apache.dubbo.remoting.exchange.Request 
(assert (not (= var123 null-var1037)))
(declare-const var894 var2356) ; Statement: r3 := @parameter1: java.lang.Throwable 
(assert (not (= var894 null-var2356)))
(define-const var1397 var3180 var3180-init) ; Statement: $r0 = new org.apache.dubbo.remoting.exchange.Response 
(assert true)
(define-const var1574 Int (getId/-1251157979 var123)) ; Statement: $l0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: long getId()>() 
(assert true)
(define-const var3291 String (getVersion/440990027 var123)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>() 
(assert true)
;(assert (<init>/1624423151 var1397 var1574 var3291)) ; Statement: specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l0, $r2) 

(declare-const var1397!1 var3180)
(declare-const var1574!1 Int)
(declare-const var3291!1 String)
(define-const var2744 Bool true) ; Statement: $z0 = r3 instanceof io.netty.handler.codec.EncoderException 
 ; Statement: if $z0 == 0 goto virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(40) 
(assert (not (= (ite var2744 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (setStatus/-969168820 var1397!1 25)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(25) 

(declare-const var1397!2 var3180)
(declare-const var550 Int)
 ; Statement: goto [?= $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>(r3)] 
(assert true) ; Non Conditional
(define-const var2784 String (var2490_toString/-109309168 var894)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>(r3) 
(assert true)
;(assert (setErrorMessage/1202863900 var1397!2 var2784)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r4) 

(declare-const var1397!3 var3180)
(declare-const var2784!1 String)
 ; Statement: return $r0 
(check-sat)
; {var3180-init=([], org.apache.dubbo.remoting.exchange.Response), getId/-1251157979=([org.apache.dubbo.remoting.exchange.Request], long), getVersion/440990027=([org.apache.dubbo.remoting.exchange.Request], java.lang.String), <init>/1624423151=([org.apache.dubbo.remoting.exchange.Response, long, java.lang.String], void), setStatus/-969168820=([org.apache.dubbo.remoting.exchange.Response, byte], void), var2490_toString/-109309168=([java.lang.Throwable], java.lang.String), setErrorMessage/1202863900=([org.apache.dubbo.remoting.exchange.Response, java.lang.String], void)}
; {var1037=org.apache.dubbo.remoting.exchange.Request, var123=r1, var2356=java.lang.Throwable, var894=r3, var3180=org.apache.dubbo.remoting.exchange.Response, var1397=$r0, var1574=$l0, var3291=$r2, var2744=$z0, var550=25, var2490=org.apache.dubbo.common.utils.StringUtils, var2784=$r4}
; {org.apache.dubbo.remoting.exchange.Request=var1037, r1=var123, java.lang.Throwable=var2356, r3=var894, org.apache.dubbo.remoting.exchange.Response=var3180, $r0=var1397, $l0=var1574, $r2=var3291, $z0=var2744, 25=var550, org.apache.dubbo.common.utils.StringUtils=var2490, $r4=var2784}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.remoting.exchange.Request;	r3 := @parameter1: java.lang.Throwable;	$r0 = new org.apache.dubbo.remoting.exchange.Response;	$l0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: long getId()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>();	specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l0, $r2);	$z0 = r3 instanceof io.netty.handler.codec.EncoderException;	if $z0 == 0 goto virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(40);	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(25);	goto [?= $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>(r3)];	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>(r3);	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r4);	return $r0
;block_num 3