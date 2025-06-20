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

(declare-sort var3900 0)
(declare-sort var2018 0)
(declare-sort var2123 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun paths/1289445235 (var3900) var2018)
(declare-fun append/-1031950772 (String var2123) String)
(declare-fun cast-from-var2018-to-var2123 (var2018) var2123)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3900 var3900)
(declare-const var1839 var3900) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition 
(assert (not (= var1839 null-var3900)))
(define-const var520 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var520)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var520!1 String)
(assert (= var520!1 ""))
(assert true)
(define-const var2670 String (append/672562846 var520!1 "PathCondition{paths=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("PathCondition{paths=") 
(declare-const var520!2 String)
(assert (= var520!2 (str.++ var520!1 "PathCondition{paths=")))
(define-const var2035 var2018 (paths/1289445235 var1839)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition: java.util.Set paths> 
(assert true)
(define-const var140 String (append/-1031950772 var2670 (cast-from-var2018-to-var2123 var2035))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2670!1 String)
(assert (str.prefixof var2670 var2670!1))
(assert true)
(define-const var3518 String (append/-1166366385 var140 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var140!1 String)
(assert (str.prefixof var140 var140!1))
(assert true)
(define-const var3840 String (toString/-2075883882 var3518)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), paths/1289445235=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition], java.util.Set), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2018-to-var2123=([java.util.Set], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3900=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition, var1839=r1, var520=$r0, var2670=$r3, var2018=java.util.Set, var2035=$r2, var2123=java.lang.Object, var140=$r4, var3518=$r5, var3840=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition=var3900, r1=var1839, $r0=var520, $r3=var2670, java.util.Set=var2018, $r2=var2035, java.lang.Object=var2123, $r4=var140, $r5=var3518, $r6=var3840}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("PathCondition{paths=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition: java.util.Set paths>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1