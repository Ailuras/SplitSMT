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

(declare-sort var3745 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun method/-562224243 (var3745) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun uri/-562224243 (var3745) String)
(declare-fun contentType/2057339566 (var3745) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3745 var3745)
(declare-const var277 var3745) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var277 null-var3745)))
(define-const var3208 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3208)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3208!1 String)
(assert (= var3208!1 ""))
(assert true)
(define-const var542 String (append/672562846 var3208!1 "method=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("method=\'") 
(declare-const var3208!2 String)
(assert (= var3208!2 (str.++ var3208!1 "method=\u0027")))
(define-const var7 String (method/-562224243 var277)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String method> 
(assert true)
(define-const var457 String (append/672562846 var542 var7)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var542!1 String)
(assert (= var542!1 (str.++ var542 var7)))
(assert true)
(define-const var3050 String (append/-1166366385 var457 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var457!1 String)
(assert (str.prefixof var457 var457!1))
(assert true)
(define-const var3012 String (append/672562846 var3050 ", uri=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", uri=\'") 
(declare-const var3050!1 String)
(assert (= var3050!1 (str.++ var3050 ", uri=\u0027")))
(define-const var2935 String (uri/-562224243 var277)) ; Statement: $r6 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String uri> 
(assert true)
(define-const var1771 String (append/672562846 var3012 var2935)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3012!1 String)
(assert (= var3012!1 (str.++ var3012 var2935)))
(assert true)
(define-const var1366 String (append/-1166366385 var1771 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1771!1 String)
(assert (str.prefixof var1771 var1771!1))
(assert true)
(define-const var87 String (append/672562846 var1366 ", contentType=\u0027")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", contentType=\'") 
(declare-const var1366!1 String)
(assert (= var1366!1 (str.++ var1366 ", contentType=\u0027")))
(assert true)
(define-const var920 String (contentType/2057339566 var277)) ; Statement: $r10 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType()>() 
(assert true)
(define-const var2155 String (append/672562846 var87 var920)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var87!1 String)
(assert (= var87!1 (str.++ var87 var920)))
(assert true)
(define-const var823 String (append/-1166366385 var2155 39)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2155!1 String)
(assert (str.prefixof var2155 var2155!1))
(assert true)
(define-const var753 String (toString/-2075883882 var823)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), method/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), uri/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), contentType/2057339566=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3745=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var277=r1, var3208=$r0, var542=$r3, var7=$r2, var457=$r4, var3050=$r5, var3012=$r7, var2935=$r6, var1771=$r8, var1366=$r9, var87=$r11, var920=$r10, var2155=$r12, var823=$r13, var753=$r14}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var3745, r1=var277, $r0=var3208, $r3=var542, $r2=var7, $r4=var457, $r5=var3050, $r7=var3012, $r6=var2935, $r8=var1771, $r9=var1366, $r11=var87, $r10=var920, $r12=var2155, $r13=var823, $r14=var753}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("method=\'");	$r2 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String method>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", uri=\'");	$r6 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String uri>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", contentType=\'");	$r10 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 1