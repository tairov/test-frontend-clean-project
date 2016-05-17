<?php

namespace AppBundle\DataFixtures\ORM;

use AppBundle\Entity\User;
use Doctrine\Common\DataFixtures\FixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

/**
 * Class LoadUserData.
 */
class LoadUserData implements FixtureInterface
{
    /**
     * Load data fixtures
     *
     * @param ObjectManager $manager
     */
    public function load(ObjectManager $manager)
    {
        $user = new User();
        $user->setIdToken('5dsf4dsf5sdf4');
        $user->setUserName('John Doe');
        $user->setUserEmail('johndoe@gmail.com');
        $user->setUserGender(User::GENDER_MALE);
        $user->setUserBirthday(new \DateTime('1983-04-15'));
        $user->setPassword('test');
        $user->setSiteUrl('www.mywebsite.com');
        $user->setUserPhone('+65 336889425');
        $user->setUserSkill(123);
        $user->setUserAbout(<<<LOREM
Nam ut dictum ligula. Mauris a purus ut lorem vestibulum ornare nec sit amet mauris.
Mauris pulvinar sagittis mauris. Maecenas vestibulum pharetra rutrum.
Duls eleifend massa odio, eu ffugiat nulla porttitor fermentum. Mauris
LOREM
);

        $manager->persist($user);
        $manager->flush();
    }
}
