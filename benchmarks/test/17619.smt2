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

(declare-sort var3383 0)
(declare-sort var3428 0)
(declare-sort var2202 0)
(declare-sort var532 0)
(declare-sort var108 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3383-to-var3428 (var3383) var3428)
(declare-fun var532-init () var532)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var108) String)
(declare-fun cast-from-var2202-to-var108 (var2202) var108)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-749193624 (var532 String var108) void)
(declare-const null-var3383 var3383)
(declare-const null-var2202 var2202)
(declare-const var1669 var3383) ; Statement: r0 := @parameter0: io.netty.handler.codec.http.multipart.InterfaceHttpData 
(assert (not (= var1669 null-var3383)))
(define-const var2029 var3428 (cast-from-var3383-to-var3428 var1669)) ; Statement: $r1 = (io.netty.handler.codec.http.multipart.Attribute) r0 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1821 var2202) ; Statement: $r3 := @caughtexception 
(assert (not (= var1821 null-var2202)))
(define-const var2063 var532 var532-init) ; Statement: $r4 = new org.apache.dubbo.remoting.http12.exception.DecodeException 
(define-const var2061 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2061)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2061!1 String)
(assert (= var2061!1 ""))
(assert true)
(define-const var1901 String (append/672562846 var2061!1 "Error while reading post value: ")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Error while reading post value: ") 
(declare-const var2061!2 String)
(assert (= var2061!2 (str.++ var2061!1 "Error while reading post value: ")))
(assert true)
(define-const var2325 String (getMessage/849299655 (cast-from-var2202-to-var108 var1821))) ; Statement: $r6 = virtualinvoke $r3.<java.io.IOException: java.lang.String getMessage()>() 
(assert true)
(define-const var488 String (append/672562846 var1901 var2325)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1901!1 String)
(assert (= var1901!1 (str.++ var1901 var2325)))
(assert true)
(define-const var1061 String (toString/-2075883882 var488)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-749193624 var2063 var1061 (cast-from-var2202-to-var108 var1821))) ; Statement: specialinvoke $r4.<org.apache.dubbo.remoting.http12.exception.DecodeException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r3) 

(declare-const var2063!1 var532)
(declare-const var1061!1 String)
(declare-const var1821!1 var2202)
 ; Statement: throw $r4 
(check-sat)
; {cast-from-var3383-to-var3428=([io.netty.handler.codec.http.multipart.InterfaceHttpData], io.netty.handler.codec.http.multipart.Attribute), var532-init=([], org.apache.dubbo.remoting.http12.exception.DecodeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2202-to-var108=([java.io.IOException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-749193624=([org.apache.dubbo.remoting.http12.exception.DecodeException, java.lang.String, java.lang.Throwable], void)}
; {var3383=io.netty.handler.codec.http.multipart.InterfaceHttpData, var1669=r0, var3428=io.netty.handler.codec.http.multipart.Attribute, var2029=$r1, var2202=java.io.IOException, var1821=$r3, var532=org.apache.dubbo.remoting.http12.exception.DecodeException, var2063=$r4, var2061=$r5, var1901=$r7, var108=java.lang.Throwable, var2325=$r6, var488=$r8, var1061=$r9}
; {io.netty.handler.codec.http.multipart.InterfaceHttpData=var3383, r0=var1669, io.netty.handler.codec.http.multipart.Attribute=var3428, $r1=var2029, java.io.IOException=var2202, $r3=var1821, org.apache.dubbo.remoting.http12.exception.DecodeException=var532, $r4=var2063, $r5=var2061, $r7=var1901, java.lang.Throwable=var108, $r6=var2325, $r8=var488, $r9=var1061}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: io.netty.handler.codec.http.multipart.InterfaceHttpData;	$r1 = (io.netty.handler.codec.http.multipart.Attribute) r0;	$r3 := @caughtexception;	$r4 = new org.apache.dubbo.remoting.http12.exception.DecodeException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Error while reading post value: ");	$r6 = virtualinvoke $r3.<java.io.IOException: java.lang.String getMessage()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<org.apache.dubbo.remoting.http12.exception.DecodeException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r3);	throw $r4
;block_num 2