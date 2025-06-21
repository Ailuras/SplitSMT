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

(declare-sort var2325 0)
(declare-sort var1856 0)
(declare-sort var1712 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1712) void)
(declare-fun cast-from-var2325-to-var1712 (var2325) var1712)
(declare-fun type/981343671 (var2325) String)
(declare-fun subType/981343671 (var2325) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun name/981343671 (var2325) String)
(declare-const null-var2325 var2325)
(declare-const null-String String)
(declare-const var916 var2325) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.MediaType 
(assert (not (= var916 null-var2325)))
(declare-const var3774 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3774 null-String)))
(declare-const var2055 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2055 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2325-to-var1712 var916))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var916!1 var2325)
(declare-const var916!2 var2325)
(assert (not (= var916!2 null-var2325)))
(assert (= (type/981343671 var916!2) var3774)) ; Statement: r0.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String type> = r1 
(declare-const var916!3 var2325)
(assert (not (= var916!3 null-var2325)))
(assert (= (subType/981343671 var916!3) var2055)) ; Statement: r0.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String subType> = r2 
(define-const var2765 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2765)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2765!1 String)
(assert (= var2765!1 ""))
(assert true)
(define-const var3854 String (append/672562846 var2765!1 var3774)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2765!2 String)
(assert (= var2765!2 (str.++ var2765!1 var3774)))
(assert true)
(define-const var2329 String (append/-1166366385 var3854 47)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var3854!1 String)
(assert (str.prefixof var3854 var3854!1))
(assert true)
(define-const var1928 String (append/672562846 var2329 var2055)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2329!1 String)
(assert (= var2329!1 (str.++ var2329 var2055)))
(assert true)
(define-const var3691 String (toString/-2075883882 var1928)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var916!4 var2325)
(assert (not (= var916!4 null-var2325)))
(assert (= (name/981343671 var916!4) var3691)) ; Statement: r0.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String name> = $r7 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2325-to-var1712=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.Object), type/981343671=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), subType/981343671=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), name/981343671=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String)}
; {var2325=org.apache.dubbo.remoting.http12.message.MediaType, var916=r0, var3774=r1, var1856=null_type, var2055=r2, var1712=java.lang.Object, var2765=$r3, var3854=$r4, var2329=$r5, var1928=$r6, var3691=$r7}
; {org.apache.dubbo.remoting.http12.message.MediaType=var2325, r0=var916, r1=var3774, null_type=var1856, r2=var2055, java.lang.Object=var1712, $r3=var2765, $r4=var3854, $r5=var2329, $r6=var1928, $r7=var3691}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.MediaType;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String type> = r1;	r0.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String subType> = r2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	r0.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String name> = $r7;	return
;block_num 1