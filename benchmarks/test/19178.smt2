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

(declare-sort var179 0)
(declare-sort var2227 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getHost0/1648687943 (var179) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun localHost/9105230 (var179) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun localPort/55405721 (var179) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var179 var179)
(declare-const null-String String)
(declare-const var994 var179) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var994 null-var179)))
(assert true)
(define-const var2682 String (getHost0/1648687943 var994)) ; Statement: r1 = specialinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String getHost0()>() 
 ; Statement: if r1 != null goto $r7 = r1 
(assert (not (not (= var2682 null-String)))) ; Negate: Cond: r1 != null  
(define-const var3185 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3185)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3185!1 String)
(assert (= var3185!1 ""))
(assert true)
(define-const var2019 String (localHost/9105230 var994)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String localHost()>() 
(assert true)
(define-const var854 String (append/672562846 var3185!1 var2019)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3185!2 String)
(assert (= var3185!2 (str.++ var3185!1 var2019)))
(assert true)
(define-const var1264 String (append/-1166366385 var854 58)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var854!1 String)
(assert (str.prefixof var854 var854!1))
(assert true)
(define-const var2591 Int (localPort/55405721 var994)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: int localPort()>() 
(assert true)
(define-const var2912 String (append/-1001720160 var1264 var2591)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1264!1 String)
(assert (str.prefixof var1264 var1264!1))
(assert true)
(define-const var104 String (toString/-2075883882 var2912)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= return $r7] 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {getHost0/1648687943=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), localHost/9105230=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), localPort/55405721=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var179=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var994=r0, var2682=r1, var2227=null_type, var3185=$r2, var2019=$r3, var854=$r4, var1264=$r5, var2591=$i0, var2912=$r6, var104=$r7}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var179, r0=var994, r1=var2682, null_type=var2227, $r2=var3185, $r3=var2019, $r4=var854, $r5=var1264, $i0=var2591, $r6=var2912, $r7=var104}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r1 = specialinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String getHost0()>();	if r1 != null goto $r7 = r1;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String localHost()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$i0 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: int localPort()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= return $r7];	return $r7
;block_num 3