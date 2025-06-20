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

(declare-sort var1135 0)
(declare-sort var2213 0)
(declare-sort var3871 0)
(declare-sort var17 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun body/1982979722 (var1135) var2213)
(declare-fun var3871_toShortString/699095716 (var17) String)
(declare-fun cast-from-var2213-to-var17 (var2213) var17)
(declare-fun streamId/1982979722 (var1135) Int)
(declare-fun append/-901862667 (String Int) String)
(declare-fun endStream/1982979722 (var1135) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1135 var1135)
(declare-const var1409 var1135) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame 
(assert (not (= var1409 null-var1135)))
(define-const var3006 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3006)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3006!1 String)
(assert (= var3006!1 ""))
(assert true)
(define-const var1424 String (append/672562846 var3006!1 "Http2InputMessageFrame{body=")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http2InputMessageFrame{body=") 
(declare-const var3006!2 String)
(assert (= var3006!2 (str.++ var3006!1 "Http2InputMessageFrame{body=")))
(define-const var2245 var2213 (body/1982979722 var1409)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame: java.io.InputStream body> 
(define-const var1850 String (var3871_toShortString/699095716 (cast-from-var2213-to-var17 var2245))) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String toShortString(java.lang.Object)>($r2) 
(assert true)
(define-const var951 String (append/672562846 var1424 var1850)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1424!1 String)
(assert (= var1424!1 (str.++ var1424 var1850)))
(assert true)
(define-const var1814 String (append/672562846 var951 ", body=")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", body=") 
(declare-const var951!1 String)
(assert (= var951!1 (str.++ var951 ", body=")))
(define-const var143 Int (streamId/1982979722 var1409)) ; Statement: $l0 = r1.<org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame: long streamId> 
(assert true)
(define-const var2871 String (append/-901862667 var1814 var143)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0) 
(declare-const var1814!1 String)
(assert (str.prefixof var1814 var1814!1))
(assert true)
(define-const var2194 String (append/672562846 var2871 ", endStream=")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", endStream=") 
(declare-const var2871!1 String)
(assert (= var2871!1 (str.++ var2871 ", endStream=")))
(define-const var3312 Bool (endStream/1982979722 var1409)) ; Statement: $z0 = r1.<org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame: boolean endStream> 
(assert true)
(define-const var84 String (append/-388390247 var2194 var3312)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var2194!1 String)
(assert (str.prefixof var2194 var2194!1))
(assert true)
(define-const var2573 String (append/-1166366385 var84 125)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var84!1 String)
(assert (str.prefixof var84 var84!1))
(assert true)
(define-const var619 String (toString/-2075883882 var2573)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), body/1982979722=([org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame], java.io.InputStream), var3871_toShortString/699095716=([java.lang.Object], java.lang.String), cast-from-var2213-to-var17=([java.io.InputStream], java.lang.Object), streamId/1982979722=([org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), endStream/1982979722=([org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1135=org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame, var1409=r1, var3006=$r0, var1424=$r4, var2213=java.io.InputStream, var2245=$r2, var3871=org.apache.dubbo.common.utils.ClassUtils, var17=java.lang.Object, var1850=$r3, var951=$r5, var1814=$r6, var143=$l0, var2871=$r7, var2194=$r8, var3312=$z0, var84=$r9, var2573=$r10, var619=$r11}
; {org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame=var1135, r1=var1409, $r0=var3006, $r4=var1424, java.io.InputStream=var2213, $r2=var2245, org.apache.dubbo.common.utils.ClassUtils=var3871, java.lang.Object=var17, $r3=var1850, $r5=var951, $r6=var1814, $l0=var143, $r7=var2871, $r8=var2194, $z0=var3312, $r9=var84, $r10=var2573, $r11=var619}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http2InputMessageFrame{body=");	$r2 = r1.<org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame: java.io.InputStream body>;	$r3 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String toShortString(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", body=");	$l0 = r1.<org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame: long streamId>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", endStream=");	$z0 = r1.<org.apache.dubbo.remoting.http12.h2.Http2InputMessageFrame: boolean endStream>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 1