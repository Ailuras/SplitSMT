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

(declare-sort var2296 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun serviceInterfaceName/402709206 (var2296) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun version/402709206 (var2296) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2296 var2296)
(declare-const var1243 var2296) ; Statement: r1 := @this: org.apache.dubbo.common.BaseServiceMetadata 
(assert (not (= var1243 null-var2296)))
(define-const var2668 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2668)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2668!1 String)
(assert (= var2668!1 ""))
(define-const var1782 String (serviceInterfaceName/402709206 var1243)) ; Statement: $r2 = r1.<org.apache.dubbo.common.BaseServiceMetadata: java.lang.String serviceInterfaceName> 
(assert true)
;(assert (append/672562846 var2668!1 var1782)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2668!2 String)
(assert (= var2668!2 (str.++ var2668!1 var1782)))
(assert true)
(define-const var3441 String (append/-1166366385 var2668!2 58)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2668!3 String)
(assert (str.prefixof var2668!2 var2668!3))
(define-const var3841 String (version/402709206 var1243)) ; Statement: $r3 = r1.<org.apache.dubbo.common.BaseServiceMetadata: java.lang.String version> 
(assert true)
;(assert (append/672562846 var3441 var3841)) ; Statement: virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3441!1 String)
(assert (= var3441!1 (str.++ var3441 var3841)))
(assert true)
(define-const var3068 String (toString/-2075883882 var2668!3)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), serviceInterfaceName/402709206=([org.apache.dubbo.common.BaseServiceMetadata], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), version/402709206=([org.apache.dubbo.common.BaseServiceMetadata], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2296=org.apache.dubbo.common.BaseServiceMetadata, var1243=r1, var2668=$r0, var1782=$r2, var3441=$r4, var3841=$r3, var3068=$r5}
; {org.apache.dubbo.common.BaseServiceMetadata=var2296, r1=var1243, $r0=var2668, $r2=var1782, $r4=var3441, $r3=var3841, $r5=var3068}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.BaseServiceMetadata;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.common.BaseServiceMetadata: java.lang.String serviceInterfaceName>;	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r3 = r1.<org.apache.dubbo.common.BaseServiceMetadata: java.lang.String version>;	virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 1