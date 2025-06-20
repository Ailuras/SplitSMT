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

(declare-sort var593 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getRemoteHost/1142844354 (var593) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getRemotePort/-872540125 (var593) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var593 var593)
(declare-const var1129 var593) ; Statement: r1 := @this: org.apache.dubbo.rpc.RpcServiceContext 
(assert (not (= var1129 null-var593)))
(define-const var1187 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1187)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1187!1 String)
(assert (= var1187!1 ""))
(assert true)
(define-const var1082 String (getRemoteHost/1142844354 var1129)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getRemoteHost()>() 
(assert true)
(define-const var2368 String (append/672562846 var1187!1 var1082)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1187!2 String)
(assert (= var1187!2 (str.++ var1187!1 var1082)))
(assert true)
(define-const var3900 String (append/672562846 var2368 ":")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var2368!1 String)
(assert (= var2368!1 (str.++ var2368 ":")))
(assert true)
(define-const var3286 Int (getRemotePort/-872540125 var1129)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.rpc.RpcServiceContext: int getRemotePort()>() 
(assert true)
(define-const var3238 String (append/-1001720160 var3900 var3286)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3900!1 String)
(assert (str.prefixof var3900 var3900!1))
(assert true)
(define-const var28 String (toString/-2075883882 var3238)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getRemoteHost/1142844354=([org.apache.dubbo.rpc.RpcServiceContext], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getRemotePort/-872540125=([org.apache.dubbo.rpc.RpcServiceContext], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var593=org.apache.dubbo.rpc.RpcServiceContext, var1129=r1, var1187=$r0, var1082=$r2, var2368=$r3, var3900=$r4, var3286=$i0, var3238=$r5, var28=$r6}
; {org.apache.dubbo.rpc.RpcServiceContext=var593, r1=var1129, $r0=var1187, $r2=var1082, $r3=var2368, $r4=var3900, $i0=var3286, $r5=var3238, $r6=var28}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.RpcServiceContext;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getRemoteHost()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$i0 = virtualinvoke r1.<org.apache.dubbo.rpc.RpcServiceContext: int getRemotePort()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1