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

(declare-sort var509 0)
(declare-sort var3821 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun name/1248552812 (var509) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun value/1248552812 (var509) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun domain/1248552812 (var509) String)
(declare-fun path/1248552812 (var509) String)
(declare-fun maxAge/1248552812 (var509) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun secure/1248552812 (var509) Bool)
(declare-fun httpOnly/1248552812 (var509) Bool)
(declare-fun sameSite/1248552812 (var509) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var509 var509)
(declare-const null-String String)
(declare-const var772 var509) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.HttpCookie 
(assert (not (= var772 null-var509)))
(define-const var2662 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(define-const var649 String (name/1248552812 var772)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String name> 
(assert true)
;(assert (<init>/-1061048412 var2662 var649)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var2662!1 String)
(assert (= var2662!1 var649))
(assert true)
(define-const var1861 String (append/-1166366385 var2662!1 61)) ; Statement: $r4 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(61) 
(declare-const var2662!2 String)
(assert (str.prefixof var2662!1 var2662!2))
(define-const var1037 String (value/1248552812 var772)) ; Statement: $r3 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String value> 
(assert true)
(define-const var250 String (append/672562846 var1861 var1037)) ; Statement: r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1861!1 String)
(assert (= var1861!1 (str.++ var1861 var1037)))
(define-const var1711 String (domain/1248552812 var772)) ; Statement: $r6 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String domain> 
 ; Statement: if $r6 == null goto $r7 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String path> 
(assert (= var1711 null-String)) ; Cond: $r6 == null 
(define-const var2834 String (path/1248552812 var772)) ; Statement: $r7 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String path> 
 ; Statement: if $r7 == null goto $l0 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: long maxAge> 
(assert (= var2834 null-String)) ; Cond: $r7 == null 
(define-const var615 Int (maxAge/1248552812 var772)) ; Statement: $l0 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: long maxAge> 
(define-const var2360 Int (ite (> var615 0) 1 (ite (< var615 0) -1 0))) ; Statement: $b1 = $l0 cmp 0L 
(define-const var3637 Int (cast-from-Int-to-Int var2360)) ; Statement: $i3 = (int) $b1 
 ; Statement: if $i3 < 0 goto $z0 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: boolean secure> 
(assert (< var3637 0)) ; Cond: $i3 < 0 
(define-const var1288 Bool (secure/1248552812 var772)) ; Statement: $z0 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: boolean secure> 
 ; Statement: if $z0 == 0 goto $z1 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: boolean httpOnly> 
(assert (= (ite var1288 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2645 Bool (httpOnly/1248552812 var772)) ; Statement: $z1 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: boolean httpOnly> 
 ; Statement: if $z1 == 0 goto $r8 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String sameSite> 
(assert (= (ite var2645 1 0) 0)) ; Cond: $z1 == 0 
(define-const var855 String (sameSite/1248552812 var772)) ; Statement: $r8 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String sameSite> 
 ; Statement: if $r8 == null goto $r9 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var855 null-String)) ; Cond: $r8 == null 
(assert true)
(define-const var2622 String (toString/-2075883882 var250)) ; Statement: $r9 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), name/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), value/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), domain/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], java.lang.String), path/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], java.lang.String), maxAge/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], long), cast-from-Int-to-Int=([byte], int), secure/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], boolean), httpOnly/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], boolean), sameSite/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var509=org.apache.dubbo.remoting.http12.HttpCookie, var772=r1, var2662=$r18, var649=$r2, var1861=$r4, var1037=$r3, var250=r5, var1711=$r6, var3821=null_type, var2834=$r7, var615=$l0, var2360=$b1, var3637=$i3, var1288=$z0, var2645=$z1, var855=$r8, var2622=$r9}
; {org.apache.dubbo.remoting.http12.HttpCookie=var509, r1=var772, $r18=var2662, $r2=var649, $r4=var1861, $r3=var1037, r5=var250, $r6=var1711, null_type=var3821, $r7=var2834, $l0=var615, $b1=var2360, $i3=var3637, $z0=var1288, $z1=var2645, $r8=var855, $r9=var2622}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.HttpCookie;	$r18 = new java.lang.StringBuilder;	$r2 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String name>;	specialinvoke $r18.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	$r4 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(61);	$r3 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String value>;	r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String domain>;	if $r6 == null goto $r7 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String path>;	$r7 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String path>;	if $r7 == null goto $l0 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: long maxAge>;	$l0 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: long maxAge>;	$b1 = $l0 cmp 0L;	$i3 = (int) $b1;	if $i3 < 0 goto $z0 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: boolean secure>;	$z0 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: boolean secure>;	if $z0 == 0 goto $z1 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: boolean httpOnly>;	$z1 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: boolean httpOnly>;	if $z1 == 0 goto $r8 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String sameSite>;	$r8 = r1.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String sameSite>;	if $r8 == null goto $r9 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 7