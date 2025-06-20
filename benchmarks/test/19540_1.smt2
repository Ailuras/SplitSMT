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

(declare-sort var114 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1713086373 (var114) String)
(declare-fun rate/1713086373 (var114) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun interval/1713086373 (var114) Int)
(declare-fun append/-901862667 (String Int) String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var114 var114)
(declare-const var1200 var114) ; Statement: r1 := @this: org.apache.dubbo.rpc.filter.tps.StatItem 
(assert (not (= var1200 null-var114)))
(define-const var1219 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1219)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1219!1 String)
(assert (= var1219!1 ""))
(assert true)
(define-const var1513 String (append/672562846 var1219!1 "StatItem [name=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("StatItem [name=") 
(declare-const var1219!2 String)
(assert (= var1219!2 (str.++ var1219!1 "StatItem [name=")))
(define-const var260 String (name/1713086373 var1200)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.filter.tps.StatItem: java.lang.String name> 
(assert true)
(define-const var795 String (append/672562846 var1513 var260)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1513!1 String)
(assert (= var1513!1 (str.++ var1513 var260)))
(assert true)
(define-const var1845 String (append/672562846 var795 ", rate = ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", rate = ") 
(declare-const var795!1 String)
(assert (= var795!1 (str.++ var795 ", rate = ")))
(define-const var3395 Int (rate/1713086373 var1200)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.filter.tps.StatItem: int rate> 
(assert true)
(define-const var3038 String (append/-1001720160 var1845 var3395)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1845!1 String)
(assert (str.prefixof var1845 var1845!1))
(assert true)
(define-const var240 String (append/672562846 var3038 ", interval = ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", interval = ") 
(declare-const var3038!1 String)
(assert (= var3038!1 (str.++ var3038 ", interval = ")))
(define-const var3417 Int (interval/1713086373 var1200)) ; Statement: $l1 = r1.<org.apache.dubbo.rpc.filter.tps.StatItem: long interval> 
(assert true)
(define-const var2657 String (append/-901862667 var240 var3417)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l1) 
(declare-const var240!1 String)
(assert (str.prefixof var240 var240!1))
(assert true)
(define-const var3355 String (append/-1166366385 var2657 93)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(declare-const var2657!1 String)
(assert (str.prefixof var2657 var2657!1))
(assert true)
(define-const var748 String (toString/-2075883882 var3355)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1713086373=([org.apache.dubbo.rpc.filter.tps.StatItem], java.lang.String), rate/1713086373=([org.apache.dubbo.rpc.filter.tps.StatItem], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), interval/1713086373=([org.apache.dubbo.rpc.filter.tps.StatItem], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var114=org.apache.dubbo.rpc.filter.tps.StatItem, var1200=r1, var1219=$r0, var1513=$r3, var260=$r2, var795=$r4, var1845=$r5, var3395=$i0, var3038=$r6, var240=$r7, var3417=$l1, var2657=$r8, var3355=$r9, var748=$r10}
; {org.apache.dubbo.rpc.filter.tps.StatItem=var114, r1=var1200, $r0=var1219, $r3=var1513, $r2=var260, $r4=var795, $r5=var1845, $i0=var3395, $r6=var3038, $r7=var240, $l1=var3417, $r8=var2657, $r9=var3355, $r10=var748}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.filter.tps.StatItem;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("StatItem [name=");	$r2 = r1.<org.apache.dubbo.rpc.filter.tps.StatItem: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", rate = ");	$i0 = r1.<org.apache.dubbo.rpc.filter.tps.StatItem: int rate>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", interval = ");	$l1 = r1.<org.apache.dubbo.rpc.filter.tps.StatItem: long interval>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l1);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1