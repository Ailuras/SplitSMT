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

(declare-sort var413 0)
(declare-sort var2520 0)
(declare-sort var504 0)
(declare-sort var1142 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var504-init () var504)
(declare-fun getId/-1251157979 (var413) Int)
(declare-fun getVersion/440990027 (var413) String)
(declare-fun <init>/1624423151 (var504 Int String) void)
(declare-fun setStatus/-969168820 (var504 Int) void)
(declare-fun var1142_toString/-109309168 (var2520) String)
(declare-fun setErrorMessage/1202863900 (var504 String) void)
(declare-const null-var413 var413)
(declare-const null-var2520 var2520)
(declare-const var2118 var413) ; Statement: r1 := @parameter0: org.apache.dubbo.remoting.exchange.Request 
(assert (not (= var2118 null-var413)))
(declare-const var1792 var2520) ; Statement: r3 := @parameter1: java.lang.Throwable 
(assert (not (= var1792 null-var2520)))
(define-const var2771 var504 var504-init) ; Statement: $r0 = new org.apache.dubbo.remoting.exchange.Response 
(assert true)
(define-const var1891 Int (getId/-1251157979 var2118)) ; Statement: $l0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: long getId()>() 
(assert true)
(define-const var2992 String (getVersion/440990027 var2118)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>() 
(assert true)
;(assert (<init>/1624423151 var2771 var1891 var2992)) ; Statement: specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l0, $r2) 

(declare-const var2771!1 var504)
(declare-const var1891!1 Int)
(declare-const var2992!1 String)
(define-const var3243 Bool true) ; Statement: $z0 = r3 instanceof io.netty.handler.codec.EncoderException 
 ; Statement: if $z0 == 0 goto virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(40) 
(assert (= (ite var3243 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (setStatus/-969168820 var2771!1 40)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(40) 

(declare-const var2771!2 var504)
(declare-const var112 Int)
(assert true) ; Non Conditional
(define-const var742 String (var1142_toString/-109309168 var1792)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>(r3) 
(assert true)
;(assert (setErrorMessage/1202863900 var2771!2 var742)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r4) 

(declare-const var2771!3 var504)
(declare-const var742!1 String)
 ; Statement: return $r0 
(check-sat)
; {var504-init=([], org.apache.dubbo.remoting.exchange.Response), getId/-1251157979=([org.apache.dubbo.remoting.exchange.Request], long), getVersion/440990027=([org.apache.dubbo.remoting.exchange.Request], java.lang.String), <init>/1624423151=([org.apache.dubbo.remoting.exchange.Response, long, java.lang.String], void), setStatus/-969168820=([org.apache.dubbo.remoting.exchange.Response, byte], void), var1142_toString/-109309168=([java.lang.Throwable], java.lang.String), setErrorMessage/1202863900=([org.apache.dubbo.remoting.exchange.Response, java.lang.String], void)}
; {var413=org.apache.dubbo.remoting.exchange.Request, var2118=r1, var2520=java.lang.Throwable, var1792=r3, var504=org.apache.dubbo.remoting.exchange.Response, var2771=$r0, var1891=$l0, var2992=$r2, var3243=$z0, var112=40, var1142=org.apache.dubbo.common.utils.StringUtils, var742=$r4}
; {org.apache.dubbo.remoting.exchange.Request=var413, r1=var2118, java.lang.Throwable=var2520, r3=var1792, org.apache.dubbo.remoting.exchange.Response=var504, $r0=var2771, $l0=var1891, $r2=var2992, $z0=var3243, 40=var112, org.apache.dubbo.common.utils.StringUtils=var1142, $r4=var742}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.remoting.exchange.Request;	r3 := @parameter1: java.lang.Throwable;	$r0 = new org.apache.dubbo.remoting.exchange.Response;	$l0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: long getId()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>();	specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l0, $r2);	$z0 = r3 instanceof io.netty.handler.codec.EncoderException;	if $z0 == 0 goto virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(40);	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(40);	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>(r3);	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r4);	return $r0
;block_num 3