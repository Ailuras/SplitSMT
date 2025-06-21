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

(declare-sort var78 0)
(declare-sort var2029 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun method/-1821516339 (var78) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun path/-1382458295 (var78) String)
(declare-fun contentType/-209336764 (var2029) String)
(declare-fun cast-from-var78-to-var2029 (var78) var2029)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var78 var78)
(declare-const var55 var78) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request 
(assert (not (= var55 null-var78)))
(define-const var2860 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2860)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2860!1 String)
(assert (= var2860!1 ""))
(assert true)
(define-const var990 String (append/672562846 var2860!1 "Http1Request{method=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http1Request{method=\'") 
(declare-const var2860!2 String)
(assert (= var2860!2 (str.++ var2860!1 "Http1Request{method=\u0027")))
(assert true)
(define-const var3048 String (method/-1821516339 var55)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request: java.lang.String method()>() 
(assert true)
(define-const var3919 String (append/672562846 var990 var3048)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var990!1 String)
(assert (= var990!1 (str.++ var990 var3048)))
(assert true)
(define-const var3112 String (append/-1166366385 var3919 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3919!1 String)
(assert (str.prefixof var3919 var3919!1))
(assert true)
(define-const var1887 String (append/672562846 var3112 ", path=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", path=\'") 
(declare-const var3112!1 String)
(assert (= var3112!1 (str.++ var3112 ", path=\u0027")))
(assert true)
(define-const var951 String (path/-1382458295 var55)) ; Statement: $r6 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request: java.lang.String path()>() 
(assert true)
(define-const var380 String (append/672562846 var1887 var951)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1887!1 String)
(assert (= var1887!1 (str.++ var1887 var951)))
(assert true)
(define-const var1736 String (append/-1166366385 var380 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var380!1 String)
(assert (str.prefixof var380 var380!1))
(assert true)
(define-const var3701 String (append/672562846 var1736 ", contentType=\u0027")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", contentType=\'") 
(declare-const var1736!1 String)
(assert (= var1736!1 (str.++ var1736 ", contentType=\u0027")))
(assert true)
(define-const var1011 String (contentType/-209336764 (cast-from-var78-to-var2029 var55))) ; Statement: $r10 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request: java.lang.String contentType()>() 
(assert true)
(define-const var3377 String (append/672562846 var3701 var1011)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var3701!1 String)
(assert (= var3701!1 (str.++ var3701 var1011)))
(assert true)
(define-const var1810 String (append/672562846 var3377 "\u0027}")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'}") 
(declare-const var3377!1 String)
(assert (= var3377!1 (str.++ var3377 "\u0027}")))
(assert true)
(define-const var1948 String (toString/-2075883882 var1810)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), method/-1821516339=([org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), path/-1382458295=([org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request], java.lang.String), contentType/-209336764=([org.apache.dubbo.remoting.http12.HttpMetadata], java.lang.String), cast-from-var78-to-var2029=([org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request], org.apache.dubbo.remoting.http12.HttpMetadata), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var78=org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request, var55=r1, var2860=$r0, var990=$r3, var3048=$r2, var3919=$r4, var3112=$r5, var1887=$r7, var951=$r6, var380=$r8, var1736=$r9, var3701=$r11, var2029=org.apache.dubbo.remoting.http12.HttpMetadata, var1011=$r10, var3377=$r12, var1810=$r13, var1948=$r14}
; {org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request=var78, r1=var55, $r0=var2860, $r3=var990, $r2=var3048, $r4=var3919, $r5=var3112, $r7=var1887, $r6=var951, $r8=var380, $r9=var1736, $r11=var3701, org.apache.dubbo.remoting.http12.HttpMetadata=var2029, $r10=var1011, $r12=var3377, $r13=var1810, $r14=var1948}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http1Request{method=\'");	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request: java.lang.String method()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", path=\'");	$r6 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request: java.lang.String path()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", contentType=\'");	$r10 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.h1.DefaultHttp1Request: java.lang.String contentType()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'}");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 1