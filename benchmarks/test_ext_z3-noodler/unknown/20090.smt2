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

(declare-sort var727 0)
(declare-sort var663 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun status/-196148477 (var727) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun contentType/-666020608 (var727) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun body/-196148477 (var727) var663)
(declare-fun append/-1031950772 (String var663) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var727 var727)
(declare-const var1819 var727) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse 
(assert (not (= var1819 null-var727)))
(define-const var883 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var883)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var883!1 String)
(assert (= var883!1 ""))
(assert true)
(define-const var136 String (append/672562846 var883!1 "status=")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("status=") 
(declare-const var883!2 String)
(assert (= var883!2 (str.++ var883!1 "status=")))
(define-const var298 Int (status/-196148477 var1819)) ; Statement: $i0 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: int status> 
(assert true)
(define-const var996 String (append/-1001720160 var136 var298)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var136!1 String)
(assert (str.prefixof var136 var136!1))
(assert true)
(define-const var2233 String (append/672562846 var996 ", contentType=\u0027")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", contentType=\'") 
(declare-const var996!1 String)
(assert (= var996!1 (str.++ var996 ", contentType=\u0027")))
(assert true)
(define-const var3931 String (contentType/-666020608 var1819)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String contentType()>() 
(assert true)
(define-const var1910 String (append/672562846 var2233 var3931)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2233!1 String)
(assert (= var2233!1 (str.++ var2233 var3931)))
(assert true)
(define-const var1933 String (append/-1166366385 var1910 39)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1910!1 String)
(assert (str.prefixof var1910 var1910!1))
(assert true)
(define-const var3426 String (append/672562846 var1933 ", body=")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", body=") 
(declare-const var1933!1 String)
(assert (= var1933!1 (str.++ var1933 ", body=")))
(define-const var85 var663 (body/-196148477 var1819)) ; Statement: $r8 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.Object body> 
(assert true)
(define-const var2345 String (append/-1031950772 var3426 var85)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var3426!1 String)
(assert (str.prefixof var3426 var3426!1))
(assert true)
(define-const var1874 String (toString/-2075883882 var2345)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), status/-196148477=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), contentType/-666020608=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), body/-196148477=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var727=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var1819=r1, var883=$r0, var136=$r2, var298=$i0, var996=$r3, var2233=$r5, var3931=$r4, var1910=$r6, var1933=$r7, var3426=$r9, var663=java.lang.Object, var85=$r8, var2345=$r10, var1874=$r11}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var727, r1=var1819, $r0=var883, $r2=var136, $i0=var298, $r3=var996, $r5=var2233, $r4=var3931, $r6=var1910, $r7=var1933, $r9=var3426, java.lang.Object=var663, $r8=var85, $r10=var2345, $r11=var1874}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("status=");	$i0 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: int status>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", contentType=\'");	$r4 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String contentType()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", body=");	$r8 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.Object body>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 1