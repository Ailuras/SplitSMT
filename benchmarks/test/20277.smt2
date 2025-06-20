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

(declare-sort var3480 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getLocalHost/-902608329 (var3480) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getLocalPort/-1024884828 (var3480) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3480 var3480)
(declare-const var1943 var3480) ; Statement: r1 := @this: org.apache.dubbo.rpc.RpcServiceContext 
(assert (not (= var1943 null-var3480)))
(define-const var2880 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2880)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2880!1 String)
(assert (= var2880!1 ""))
(assert true)
(define-const var3821 String (getLocalHost/-902608329 var1943)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getLocalHost()>() 
(assert true)
(define-const var585 String (append/672562846 var2880!1 var3821)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2880!2 String)
(assert (= var2880!2 (str.++ var2880!1 var3821)))
(assert true)
(define-const var890 String (append/672562846 var585 ":")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var585!1 String)
(assert (= var585!1 (str.++ var585 ":")))
(assert true)
(define-const var829 Int (getLocalPort/-1024884828 var1943)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.rpc.RpcServiceContext: int getLocalPort()>() 
(assert true)
(define-const var2336 String (append/-1001720160 var890 var829)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var890!1 String)
(assert (str.prefixof var890 var890!1))
(assert true)
(define-const var792 String (toString/-2075883882 var2336)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getLocalHost/-902608329=([org.apache.dubbo.rpc.RpcServiceContext], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getLocalPort/-1024884828=([org.apache.dubbo.rpc.RpcServiceContext], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3480=org.apache.dubbo.rpc.RpcServiceContext, var1943=r1, var2880=$r0, var3821=$r2, var585=$r3, var890=$r4, var829=$i0, var2336=$r5, var792=$r6}
; {org.apache.dubbo.rpc.RpcServiceContext=var3480, r1=var1943, $r0=var2880, $r2=var3821, $r3=var585, $r4=var890, $i0=var829, $r5=var2336, $r6=var792}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.RpcServiceContext;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.RpcServiceContext: java.lang.String getLocalHost()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$i0 = virtualinvoke r1.<org.apache.dubbo.rpc.RpcServiceContext: int getLocalPort()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1